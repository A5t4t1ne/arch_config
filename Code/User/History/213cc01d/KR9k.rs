use clap::Parser;

#[derive(Parser)]
struct CLI {
    arg1: i32,
    arg2: i32,
}

fn main() {
    println!("Hello, world!");
}
