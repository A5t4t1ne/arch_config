fn main() {
    let range = 1_000_000;

    let i: f64 = 1;

    for _ in 1..range {
        i += i;
    }

    println!("{i}");
}
