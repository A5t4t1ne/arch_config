use clap::Parser;

#[derive(Parser, Debug)]
struct CLI {
    num: i32,
    #[arg(short, long, value_name = "yay_path")]
    path: std::path::PathBuf,
}

fn main() {
    let args = CLI::parse();

    println!("yes: {}, no: {:?}", args.num, args.path);
}
