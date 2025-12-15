use clap::{Arg, Command};
use day04::{grid::Grid, part2::get_result};
use std::fs;

fn main() {
    let matches = Command::new("part1")
        .arg(
            Arg::new("input")
                .short('i')
                .long("input")
                .required(true)
                .value_name("FILE")
                .help("Path to input file"),
        )
        .get_matches();
    let input_path = matches
        .get_one::<String>("input")
        .expect("input argument is required");
    let contents = fs::read_to_string(input_path).expect("failed to read the specified input file");

    let grid: Grid = contents
        .lines()
        .map(|line| line.chars().collect::<Vec<char>>())
        .collect();

    println!("Result: {}", get_result(&grid));
}
