import Day10
import Foundation

let example = """
    [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
    [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
    """

let machines = MachineParser.parse(example)

var failures = 0

func check(_ name: String, _ actual: Int, _ expected: Int) {
    if actual == expected {
        print("ok \(name)")
    } else {
        print("FAIL \(name): expected \(expected), got \(actual)")
        failures += 1
    }
}

check("part1 light count", machines.count, 3)
check("part1 first machine", Factory.fewestPresses(machines[0]), 2)
check("part1 second machine", Factory.fewestPresses(machines[1]), 3)
check("part1 third machine", Factory.fewestPresses(machines[2]), 2)
check("part2 first machine", JoltageFactory.fewestPresses(machines[0]), 10)
check("part2 second machine", JoltageFactory.fewestPresses(machines[1]), 12)
check("part2 third machine", JoltageFactory.fewestPresses(machines[2]), 11)

exit(failures == 0 ? 0 : 1)
