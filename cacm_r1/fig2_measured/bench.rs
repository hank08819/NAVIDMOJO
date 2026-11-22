// Three kernels, single thread. Build: rustc -C opt-level=3 -C target-cpu=native
use std::time::Instant;
fn rnd(st: &mut u64) -> f64 { *st = st.wrapping_mul(6364136223846793005).wrapping_add(1442695040888963407); (*st >> 11) as f64 * (1.0 / 9007199254740992.0) }

fn matmul(a: &[f64], b: &[f64], c: &mut [f64], n: usize) {
    for i in 0..n {
        for k in 0..n {
            let x = a[i * n + k];
            let brow = &b[k * n..k * n + n];
            let crow = &mut c[i * n..i * n + n];
            for j in 0..n { crow[j] += x * brow[j]; }
        }
    }
}

fn qsort_it(a: &mut [f64]) {
    let n = a.len() as isize;
    let mut stack: Vec<isize> = vec![0, n - 1];
    while let Some(mut hi) = stack.pop() {
        let mut lo = stack.pop().unwrap();
        while hi - lo > 16 {
            let mid = lo + (hi - lo) / 2;
            let (x, y, z) = (a[lo as usize], a[mid as usize], a[hi as usize]);
            let p = if x < y { if y < z { y } else if x < z { z } else { x } } else { if x < z { x } else if y < z { z } else { y } };
            let (mut i, mut j) = (lo, hi);
            while i <= j {
                while a[i as usize] < p { i += 1; }
                while a[j as usize] > p { j -= 1; }
                if i <= j { a.swap(i as usize, j as usize); i += 1; j -= 1; }
            }
            if j - lo < hi - i { stack.push(i); stack.push(hi); hi = j; } else { stack.push(lo); stack.push(j); lo = i; }
        }
        let mut i = lo + 1;
        while i <= hi {
            let v = a[i as usize]; let mut j = i - 1;
            while j >= lo && a[j as usize] > v { a[(j + 1) as usize] = a[j as usize]; j -= 1; }
            a[(j + 1) as usize] = v; i += 1;
        }
    }
}

const P10: [f64; 10] = [1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0, 1000000.0, 10000000.0, 100000000.0, 1000000000.0];
fn parse(s: &[u8]) -> (i64, i64, i64, i64, f64) {
    let (mut sts, mut ssym, mut sq, mut rec, mut spx) = (0i64, 0i64, 0i64, 0i64, 0.0f64);
    let n = s.len(); let mut i = 0usize;
    while i < n {
        while s[i] != b':' { i += 1; } i += 1;
        let mut ts = 0i64; while s[i] >= b'0' && s[i] <= b'9' { ts = ts * 10 + (s[i] - b'0') as i64; i += 1; }
        while s[i] != b':' { i += 1; } i += 2;
        let mut h = 0i64; while s[i] != b'"' { h += s[i] as i64; i += 1; }
        while s[i] != b':' { i += 1; } i += 1;
        let mut m = 0i64; while s[i] >= b'0' && s[i] <= b'9' { m = m * 10 + (s[i] - b'0') as i64; i += 1; }
        let mut k = 0usize;
        if s[i] == b'.' { i += 1; while s[i] >= b'0' && s[i] <= b'9' { m = m * 10 + (s[i] - b'0') as i64; i += 1; k += 1; } }
        while s[i] != b':' { i += 1; } i += 1;
        let mut q = 0i64; while s[i] >= b'0' && s[i] <= b'9' { q = q * 10 + (s[i] - b'0') as i64; i += 1; }
        while s[i] != b'\n' { i += 1; } i += 1;
        sts += ts; ssym += h; spx += m as f64 / P10[k]; sq += q; rec += 1;
    }
    (sts, ssym, sq, rec, spx)
}

fn main() {
    let path = std::env::args().nth(1).unwrap();
    { let n = 512usize; let mut st = 1u64;
      let a: Vec<f64> = (0..n * n).map(|_| rnd(&mut st)).collect(); let b: Vec<f64> = (0..n * n).map(|_| rnd(&mut st)).collect();
      let mut c = vec![0.0f64; n * n]; let mut best = f64::MAX;
      for _ in 0..5 { c.iter_mut().for_each(|v| *v = 0.0); let t0 = Instant::now(); matmul(&a, &b, &mut c, n); let d = t0.elapsed().as_secs_f64() * 1e3; if d < best { best = d; } }
      let mut s = 0.0; for v in &c { s += v; }
      println!("KEY matmul ms {:.3} checksum {:.6}", best, s); }
    { let n = 2000000usize; let mut st = 7u64; let x: Vec<f64> = (0..n).map(|_| rnd(&mut st)).collect();
      let mut a = x.clone(); let mut best = f64::MAX;
      for _ in 0..5 { a.copy_from_slice(&x); let t0 = Instant::now(); qsort_it(&mut a); let d = t0.elapsed().as_secs_f64() * 1e3; if d < best { best = d; } }
      let bad = (1..n).filter(|&i| a[i - 1] > a[i]).count();
      println!("KEY sort ms {:.3} unsorted {} median {:?}", best, bad, a[n / 2]); }
    { let s = std::fs::read(&path).unwrap(); let mut best = f64::MAX; let mut r = (0, 0, 0, 0, 0.0);
      for _ in 0..5 { let t0 = Instant::now(); r = parse(&s); let d = t0.elapsed().as_secs_f64() * 1e3; if d < best { best = d; } }
      println!("KEY parse ms {:.3} records {} ts {} sym {} qty {} px {:.6}", best, r.3, r.0, r.1, r.2, r.4); }
}
