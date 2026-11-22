% Three kernels, hand-written loops, same algorithm. Run: matlab -batch "bench_matlab('ticks.jsonl')"
function bench_matlab(path)
maxNumCompThreads(1);
n = 512; A = zeros(1, n*n); B = zeros(1, n*n);
st = uint64(1); [A, st] = fillrnd(A, st); [B, ~] = fillrnd(B, st);
best = inf;
for t = 1:3, tic; C = matmul(A, B, n); best = min(best, toc); end
fprintf('KEY loop matmul ms %.3f checksum %.6f\n', best*1e3, sum(C));
A2 = reshape(A, n, n).'; B2 = reshape(B, n, n).';
best = inf; for t = 1:5, tic; C2 = A2*B2; best = min(best, toc); end
fprintf('KEY builtin matmul ms %.3f checksum %.6f\n', best*1e3, sum(C2(:)));
m = 2000000; x = zeros(1, m); [x, ~] = fillrnd(x, uint64(7));
best = inf;
for t = 1:3, tic; w = qsort_it(x); best = min(best, toc); end
fprintf('KEY loop sort ms %.3f unsorted %d median %.17g\n', best*1e3, sum(w(1:end-1) > w(2:end)), w(m/2+1));
best = inf; for t = 1:5, tic; w2 = sort(x); best = min(best, toc); end
fprintf('KEY builtin sort ms %.3f median %.17g\n', best*1e3, w2(m/2+1));
fid = fopen(path, 'r'); s = double(fread(fid, inf, 'uint8=>uint8')).'; fclose(fid);
best = inf;
for t = 1:3, tic; [rec, sts, ssym, sq, spx] = parse_ticks(s); best = min(best, toc); end
fprintf('KEY loop parse ms %.3f records %d ts_mod %d sym %d qty %d px %.6f\n', best*1e3, rec, sts, ssym, sq, spx);
end

function [v, st] = fillrnd(v, st)
% 64-bit LCG done in 32-bit halves (MATLAB uint64 saturates instead of wrapping)
a = uint64(6364136223846793005); c = uint64(1442695040888963407);
M32 = uint64(4294967295);
alo = bitand(a, M32); ahi = bitshift(a, -32);
for i = 1:numel(v)
    slo = bitand(st, M32); shi = bitshift(st, -32);
    ll = slo * alo;
    mid = bitand(bitand(shi * alo, M32) + bitand(slo * ahi, M32), M32);
    hi = bitand(bitshift(ll, -32) + mid, M32);
    st = bitor(bitshift(hi, 32), bitand(ll, M32));
    % add c with wraparound
    lo2 = bitand(st, M32) + bitand(c, M32);
    hi2 = bitand(bitshift(st, -32) + bitshift(c, -32) + bitshift(lo2, -32), M32);
    st = bitor(bitshift(hi2, 32), bitand(lo2, M32));
    v(i) = double(bitshift(st, -11)) * (1.0 / 9007199254740992.0);
end
end

function c = matmul(a, b, n)
c = zeros(1, n*n);
for i = 0:n-1
    for k = 0:n-1
        x = a(i*n+k+1);
        for j = 1:n
            c(i*n+j) = c(i*n+j) + x * b(k*n+j);
        end
    end
end
end

function a = qsort_it(a)
stack = zeros(1, 256); sp = 2; stack(1) = 1; stack(2) = numel(a);
while sp > 0
    hi = stack(sp); lo = stack(sp-1); sp = sp - 2;
    while hi - lo > 16
        mid = lo + floor((hi - lo) / 2);
        x = a(lo); y = a(mid); z = a(hi);
        if x < y
            if y < z, p = y; elseif x < z, p = z; else, p = x; end
        else
            if x < z, p = x; elseif y < z, p = z; else, p = y; end
        end
        i = lo; j = hi;
        while i <= j
            while a(i) < p, i = i + 1; end
            while a(j) > p, j = j - 1; end
            if i <= j
                t = a(i); a(i) = a(j); a(j) = t; i = i + 1; j = j - 1;
            end
        end
        if j - lo < hi - i
            stack(sp+1) = i; stack(sp+2) = hi; sp = sp + 2; hi = j;
        else
            stack(sp+1) = lo; stack(sp+2) = j; sp = sp + 2; lo = i;
        end
    end
    i = lo + 1;
    while i <= hi
        v = a(i); j = i - 1;
        while j >= lo && a(j) > v
            a(j+1) = a(j); j = j - 1;
        end
        a(j+1) = v; i = i + 1;
    end
end
end

function [rec, sts, ssym, sq, spx] = parse_ticks(s)
P10 = 10.^(0:9);
n = numel(s); i = 1; sts = 0; ssym = 0; sq = 0; rec = 0; spx = 0;
while i <= n
    while s(i) ~= 58, i = i + 1; end, i = i + 1;
    ts = 0; while s(i) >= 48 && s(i) <= 57, ts = ts*10 + s(i) - 48; i = i + 1; end
    while s(i) ~= 58, i = i + 1; end, i = i + 2;
    h = 0; while s(i) ~= 34, h = h + s(i); i = i + 1; end
    while s(i) ~= 58, i = i + 1; end, i = i + 1;
    m = 0; while s(i) >= 48 && s(i) <= 57, m = m*10 + s(i) - 48; i = i + 1; end
    k = 0;
    if s(i) == 46
        i = i + 1;
        while s(i) >= 48 && s(i) <= 57, m = m*10 + s(i) - 48; i = i + 1; k = k + 1; end
    end
    while s(i) ~= 58, i = i + 1; end, i = i + 1;
    q = 0; while s(i) >= 48 && s(i) <= 57, q = q*10 + s(i) - 48; i = i + 1; end
    while s(i) ~= 10, i = i + 1; end, i = i + 1;
    sts = sts + mod(ts, 1e6); ssym = ssym + h; spx = spx + m / P10(k+1); sq = sq + q; rec = rec + 1;
end
end
