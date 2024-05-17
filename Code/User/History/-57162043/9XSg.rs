fn main() {
    int range = 1_000_000;

    double i = 1;

    for _ in 1..range {
        i += i;
    }

    println!("{i}");
}
