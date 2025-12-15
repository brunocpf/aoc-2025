use crate::grid::{Grid, get_rolls_to_remove};

pub fn get_result(paper_grid: &Grid) -> i32 {
    let matches = get_rolls_to_remove(&paper_grid).iter().count() as i32;
    matches
}

#[cfg(test)]
mod tests {
    use std::vec;

    use super::*;

    #[test]
    fn test_part1() {
        let grid = vec![
            vec!['.', '.', '@', '@', '.', '@', '@', '@', '@', '.'],
            vec!['@', '@', '@', '.', '@', '.', '@', '.', '@', '@'],
            vec!['@', '@', '@', '@', '@', '.', '@', '.', '@', '@'],
            vec!['@', '.', '@', '@', '@', '@', '.', '.', '@', '.'],
            vec!['@', '@', '.', '@', '@', '@', '@', '.', '@', '@'],
            vec!['.', '@', '@', '@', '@', '@', '@', '@', '.', '@'],
            vec!['.', '@', '.', '@', '.', '@', '.', '@', '@', '@'],
            vec!['@', '.', '@', '@', '@', '.', '@', '@', '@', '@'],
            vec!['.', '@', '@', '@', '@', '@', '@', '@', '@', '.'],
            vec!['@', '.', '@', '.', '@', '@', '@', '.', '@', '.'],
        ];

        let result = get_result(&grid);
        assert_eq!(result, 13);
    }
}
