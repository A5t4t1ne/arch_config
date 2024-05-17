fn main() {
    let range = 1_000_000;

    let mut i: f64 = 1.0;

    for _ in 1..range {
        i += i;
    }

    println!("{i}");
}
