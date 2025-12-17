export type Shape = [number, number][];
export type Region = { width: number; height: number; counts: number[] };

export function parseInput(contents: string): { shapes: Shape[]; regions: Region[] } {
  const shapes: Shape[] = [];
  const regions: Region[] = [];
  let rows: string[] = [];

  const flush = () => {
    if (rows.length > 0) {
      shapes.push(shapeFromRows(rows));
      rows = [];
    }
  };

  for (const line of contents.split("\n")) {
    if (/^\d+:/.test(line)) {
      flush();
    } else if (/^\d+x\d+:/.test(line.trim())) {
      flush();
      const [size, counts] = line.split(":");
      const [width, height] = size.split("x").map(Number);
      regions.push({ width, height, counts: counts.trim().split(/\s+/).map(Number) });
    } else if (line.trim().length > 0) {
      rows.push(line.trim());
    }
  }

  flush();
  return { shapes, regions };
}

export function shapeFromRows(rows: string[]): Shape {
  const cells: Shape = [];

  rows.forEach((row, y) => {
    [...row].forEach((char, x) => {
      if (char === "#") {
        cells.push([x, y]);
      }
    });
  });

  return cells;
}

export function fits(region: Region, shapes: Shape[]): boolean {
  const presentCells = shapes.reduce(
    (sum, shape, index) => sum + region.counts[index] * shape.length,
    0,
  );

  return presentCells <= region.width * region.height;
}
