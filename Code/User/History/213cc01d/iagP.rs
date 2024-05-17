use clap::Parser;

#[derive(Parser, Debug)]
struct CLI {
    file_name: String,
    #[arg(short, long, value_name = "starting point", default_value = ".\\")]
    path: std::path::PathBuf,
}

fn main() {
    let args = CLI::parse();

    println!("yes: {}, no: {:?}", args.file_name, args.path);
}
