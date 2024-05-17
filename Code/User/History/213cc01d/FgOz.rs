use clap::Parser;

#[derive(Parser, Debug)]
struct CLI {
    num: i32,
    // #[arg()]
    path: std::path::PathBuf,
}

fn main() {
    let args = CLI::parse();

    println!("yes: {}, no: {}", args.num, args.path);
}
