import { readFileSync } from "node:fs";
import { parseInput, fits } from "./solver.ts";

const path = inputPath(process.argv.slice(2));

if (!path) {
  console.log("Error: Please provide an input file using --input or -i.");
  process.exit(1);
}

try {
  const { shapes, regions } = parseInput(readFileSync(path, "utf8"));
  const total = regions.reduce((count, region) => count + (fits(region, shapes) ? 1 : 0), 0);
  console.log(`Result: ${total}`);
} catch (error) {
  console.log(`Error reading file: ${error}`);
  process.exit(1);
}

function inputPath(args: string[]): string | undefined {
  const index = args.findIndex((arg) => arg === "--input" || arg === "-i");
  return index >= 0 ? args[index + 1] : args[0];
}
