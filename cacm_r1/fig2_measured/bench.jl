# Three kernels, single thread, same algorithm. Run: julia -t 1 bench.jl ticks.jsonl
# Loops use @inbounds (no bounds checks, as in C++); no @simd, no @fastmath.
using Printf
function rnd(st::Base.RefValue{UInt64})
    st[] = st[] * 6364136223846793005 + 1442695040888963407
    return Float64(st[] >> 11) * (1.0 / 9007199254740992.0)
end

function matmul!(c::Vector{Float64}, a::Vector{Float64}, b::Vector{Float64}, n::Int)
    @inbounds for i in 0:n-1, k in 0:n-1
        x = a[i*n+k+1]
        for j in 1:n
            c[i*n+j] += x * b[k*n+j]
        end
    end
end

function qsort_it!(a::Vector{Float64})
    stack = Int[1, length(a)]
    @inbounds while !isempty(stack)
        hi = pop!(stack); lo = pop!(stack)
        while hi - lo > 16
            mid = lo + (hi - lo) ÷ 2
            x = a[lo]; y = a[mid]; z = a[hi]
            p = x < y ? (y < z ? y : (x < z ? z : x)) : (x < z ? x : (y < z ? z : y))
            i = lo; j = hi
            while i <= j
                while a[i] < p; i += 1; end
                while a[j] > p; j -= 1; end
                if i <= j
                    a[i], a[j] = a[j], a[i]; i += 1; j -= 1
                end
            end
            if j - lo < hi - i
                push!(stack, i); push!(stack, hi); hi = j
            else
                push!(stack, lo); push!(stack, j); lo = i
            end
        end
        i = lo + 1
        while i <= hi
            v = a[i]; j = i - 1
            while j >= lo && a[j] > v
                a[j+1] = a[j]; j -= 1
            end
            a[j+1] = v; i += 1
        end
    end
end

const P10 = [10.0^k for k in 0:9]
function parse_ticks(s::Vector{UInt8})
    n = length(s); i = 1
    sts = 0; ssym = 0; sq = 0; rec = 0; spx = 0.0
    @inbounds while i <= n
        while s[i] != 0x3a; i += 1; end; i += 1
        ts = 0; while 0x30 <= s[i] <= 0x39; ts = ts * 10 + Int(s[i] - 0x30); i += 1; end
        while s[i] != 0x3a; i += 1; end; i += 2
        h = 0; while s[i] != 0x22; h += Int(s[i]); i += 1; end
        while s[i] != 0x3a; i += 1; end; i += 1
        m = 0; while 0x30 <= s[i] <= 0x39; m = m * 10 + Int(s[i] - 0x30); i += 1; end
        k = 0
        if s[i] == 0x2e
            i += 1
            while 0x30 <= s[i] <= 0x39; m = m * 10 + Int(s[i] - 0x30); i += 1; k += 1; end
        end
        while s[i] != 0x3a; i += 1; end; i += 1
        q = 0; while 0x30 <= s[i] <= 0x39; q = q * 10 + Int(s[i] - 0x30); i += 1; end
        while s[i] != 0x0a; i += 1; end; i += 1
        sts += ts; ssym += h; spx += Float64(m) / P10[k+1]; sq += q; rec += 1
    end
    return rec, sts, ssym, sq, spx
end

function main()
    n = 512; st = Ref(UInt64(1))
    a = [rnd(st) for _ in 1:n*n]; b = [rnd(st) for _ in 1:n*n]; c = zeros(n * n)
    matmul!(c, a, b, n)                       # compile
    best = Inf
    for _ in 1:5
        fill!(c, 0.0); t = @elapsed matmul!(c, a, b, n); best = min(best, t)
    end
    @printf("KEY matmul ms %.3f checksum %.6f\n", best * 1e3, sum(c))
    m = 2000000; st = Ref(UInt64(7)); x = [rnd(st) for _ in 1:m]; w = copy(x)
    qsort_it!(copy(x[1:1000]))                # compile
    best = Inf
    for _ in 1:5
        copyto!(w, x); t = @elapsed qsort_it!(w); best = min(best, t)
    end
    @printf("KEY sort ms %.3f unsorted %d median %.17g\n", best * 1e3, count(i -> w[i-1] > w[i], 2:m), w[m÷2+1])
    s = read(ARGS[1]); r = parse_ticks(s[1:findfirst(==(0x0a), s)])   # compile
    best = Inf
    for _ in 1:5
        t = @elapsed (r = parse_ticks(s)); best = min(best, t)
    end
    @printf("KEY parse ms %.3f records %d ts %d sym %d qty %d px %.6f\n", best * 1e3, r...)
end
main()
