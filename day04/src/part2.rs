use crate::grid::{Grid, get_rolls_to_remove};

pub fn get_result(paper_grid: &Grid) -> i32 {
    let mut removed = 0;
    let mut current_grid = paper_grid.clone();

    loop {
        let to_remove = get_rolls_to_remove(&current_grid);
        if to_remove.iter().count() == 0 {
            break;
        }

        for (x, y) in to_remove {
            if let Some(row) = current_grid.get_mut(y) {
                row[x] = 'x';
                removed += 1;
            }
        }
    }

    removed
}

#[cfg(test)]
mod tests {
    use std::vec;

    use super::*;

    #[test]
    fn test_part2() {
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
        assert_eq!(result, 43);
    }
}
