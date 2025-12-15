pub type Grid = Vec<Vec<char>>;

pub fn get_adjacent_positions(grid: &Grid, x: usize, y: usize) -> Vec<char> {
    let dirs: [(isize, isize); 8] = [
        (-1, -1),
        (0, -1),
        (1, -1),
        (-1, 0),
        (1, 0),
        (-1, 1),
        (0, 1),
        (1, 1),
    ];

    dirs.iter()
        .filter_map(|(dx, dy)| {
            let new_x = x as isize + dx;
            let new_y = y as isize + dy;

            if new_x < 0 || new_y < 0 {
                return None;
            }

            grid.get(new_y as usize)
                .and_then(|row| row.get(new_x as usize))
                .copied()
        })
        .collect()
}

pub fn get_rolls_to_remove(grid: &Grid) -> Vec<(usize, usize)> {
    let mut rolls_to_remove: Vec<(usize, usize)> = vec![];

    for (y, row) in grid.iter().enumerate() {
        for (x, &cell) in row.iter().enumerate() {
            if cell != '@' {
                continue;
            }

            let adjacent = get_adjacent_positions(grid, x, y);
            if adjacent.iter().filter(|&&neighbor| neighbor == '@').count() < 4 {
                rolls_to_remove.push((x, y));
            }
        }
    }

    rolls_to_remove
}
