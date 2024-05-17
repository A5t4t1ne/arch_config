use clap::Parser;

#[derive(Parser)]
struct CLI {
    arg1: i32,
    path: std::path::PathBuf,
}

fn main() {
    println!("Hello, world!");
}
