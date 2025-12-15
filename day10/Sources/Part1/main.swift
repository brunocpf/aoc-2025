import Day10
import Foundation

guard let path = inputPath(CommandLine.arguments) else {
    print("Error: Please provide an input file using --input or -i.")
    exit(1)
}

do {
    let contents = try String(contentsOfFile: path, encoding: .utf8)
    let machines = MachineParser.parse(contents)
    let result = machines.reduce(0) { $0 + Factory.fewestPresses($1) }
    print("Result: \(result)")
} catch {
    print("Error reading file: \(error)")
    exit(1)
}

func inputPath(_ arguments: [String]) -> String? {
    if let index = arguments.firstIndex(where: { $0 == "--input" || $0 == "-i" }), index + 1 < arguments.count {
        return arguments[index + 1]
    }

    return arguments.dropFirst().first
}
