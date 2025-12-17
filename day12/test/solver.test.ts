import { test } from "node:test";
import assert from "node:assert/strict";
import { parseInput, fits, shapeFromRows } from "../src/solver.ts";

const example = `0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2
`;

test("parses shapes and regions", () => {
  const { shapes, regions } = parseInput(example);

  assert.equal(shapes.length, 6);
  assert.equal(regions.length, 3);
  assert.equal(shapes[0].length, 7);
  assert.deepEqual(regions[0], { width: 4, height: 4, counts: [0, 0, 0, 0, 2, 0] });
  assert.deepEqual(shapeFromRows(["#.", "##", ".#"]), [
    [0, 0],
    [0, 1],
    [1, 1],
    [1, 2],
  ]);
});

test("rejects regions that are too small", () => {
  const { shapes, regions } = parseInput(example);

  assert.equal(fits(regions[0], shapes), true);
  assert.equal(fits({ width: 3, height: 3, counts: [0, 0, 0, 0, 2, 0] }, shapes), false);
});
