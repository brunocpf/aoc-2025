import Foundation

public struct Machine {
    public let lights: UInt
    public let buttons: [[Int]]
    public let joltages: [Int]

    public init(lights: UInt, buttons: [[Int]], joltages: [Int]) {
        self.lights = lights
        self.buttons = buttons
        self.joltages = joltages
    }
}

public enum MachineParser {
    public static func parse(_ contents: String) -> [Machine] {
        contents.split(separator: "\n")
            .map { line in parseLine(String(line)) }
            .filter { $0 != nil }
            .map { $0! }
    }

    private static func parseLine(_ line: String) -> Machine? {
        guard let open = line.firstIndex(of: "["),
              let close = line.firstIndex(of: "]") else {
            return nil
        }

        let diagram = line[line.index(after: open)..<close]
        var lights: UInt = 0

        for (index, char) in diagram.enumerated() where char == "#" {
            lights |= UInt(1) << UInt(index)
        }

        var buttons: [[Int]] = []
        var rest = line[line.index(after: close)...]

        while let start = rest.firstIndex(of: "(") {
            guard let end = rest[start...].firstIndex(of: ")") else { break }

            let body = rest[rest.index(after: start)..<end]
            let indices = body.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
            buttons.append(indices)
            rest = rest[rest.index(after: end)...]
        }

        var joltages: [Int] = []

        if let start = line.firstIndex(of: "{"), let end = line.firstIndex(of: "}") {
            let body = line[line.index(after: start)..<end]
            joltages = body.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
        }

        return Machine(lights: lights, buttons: buttons, joltages: joltages)
    }
}

public enum Factory {
    public static func fewestPresses(_ machine: Machine) -> Int {
        var masks: [UInt] = []

        for button in machine.buttons {
            var mask: UInt = 0

            for light in button {
                mask |= UInt(1) << UInt(light)
            }

            masks.append(mask)
        }

        let target = machine.lights
        var best = Int.max

        func search(_ index: Int, _ state: UInt, _ presses: Int) {
            guard presses < best else { return }

            if index == masks.count {
                if state == target {
                    best = presses
                }
                return
            }

            search(index + 1, state, presses)
            search(index + 1, state ^ masks[index], presses + 1)
        }

        search(0, 0, 0)
        return best
    }
}
