public enum JoltageFactory {
    public static func fewestPresses(_ machine: Machine) -> Int {
        let counters = machine.joltages.count
        let buttons = machine.buttons
        var matrix = (0..<counters).map { counter in
            buttons.map { button in Rational(button.contains(counter) ? 1 : 0) } + [Rational(machine.joltages[counter])]
        }

        var pivots: [Int] = []
        var row = 0

        for column in 0..<buttons.count {
            guard let pivot = (row..<counters).first(where: { !matrix[$0][column].isZero }) else {
                continue
            }

            matrix.swapAt(row, pivot)

            let scale = matrix[row][column]
            matrix[row] = matrix[row].map { $0 / scale }

            for other in 0..<counters where other != row && !matrix[other][column].isZero {
                let factor = matrix[other][column]
                matrix[other] = zip(matrix[other], matrix[row]).map { $0 - factor * $1 }
            }

            pivots.append(column)
            row += 1
        }

        let free = (0..<buttons.count).filter { !pivots.contains($0) }
        var bounds: [ClosedRange<Int>] = []

        for column in free {
            let touching = (0..<counters).filter { buttons[column].contains($0) }
            bounds.append(0...(touching.map { machine.joltages[$0] }.min() ?? 0))
        }

        var values = [Int](repeating: 0, count: free.count)
        var best = Int.max

        func complete() -> [Int]? {
            var presses = [Int](repeating: 0, count: buttons.count)

            for (index, column) in free.enumerated() {
                presses[column] = values[index]
            }

            for (pivotIndex, column) in pivots.enumerated() {
                var value = matrix[pivotIndex][buttons.count]

                for (index, freeColumn) in free.enumerated() {
                    value = value - matrix[pivotIndex][freeColumn] * Rational(values[index])
                }

                if value < .zero || !value.isInteger {
                    return nil
                }

                presses[column] = value.intValue
            }

            for (counter, requirement) in machine.joltages.enumerated() {
                let total = buttons.indices.reduce(0) { sum, index in
                    sum + presses[index] * (buttons[index].contains(counter) ? 1 : 0)
                }

                if total != requirement {
                    return nil
                }
            }

            return presses
        }

        func search(_ index: Int) {
            if index == free.count {
                if let presses = complete() {
                    best = min(best, presses.reduce(0, +))
                }

                return
            }

            for value in bounds[index] {
                values[index] = value
                search(index + 1)
            }
        }

        search(0)
        return best
    }
}
