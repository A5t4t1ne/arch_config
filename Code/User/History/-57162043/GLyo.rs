fn main() {
    let range = 1_000_00;

    let mut i: u64 = 1;

    for _ in 1..range {
        for _ in 1..range {
            i += 1;
        }
    }

    println!("{i}");
}
