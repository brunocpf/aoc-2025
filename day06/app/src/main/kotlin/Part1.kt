import java.nio.file.Files

object Part1 {
    fun getResult(worksheet: List<String>): Long {
        val operators = parseOperators(worksheet.last())
        val numberLines = worksheet.dropLast(1)
        val rows = parseRows(numberLines)

        return operators.foldIndexed(0L) { problemIndex, accSum, operator ->
            val operation = Operator.getOperator(operator)
            val problemResult = aggregateProblem(rows, problemIndex, operation)
            accSum + problemResult
        }
    }

    private fun parseRows(numberLines: List<String>): List<List<Long>> =
            numberLines.map { line ->
                line.trim().split(Regex("\\s+")).map { value -> value.toLong() }
            }

    private fun parseOperators(operatorLine: String): List<Char> =
            operatorLine.trim().split(Regex("\\s+")).map { operatorString ->
                operatorString.single()
            }

    private fun aggregateProblem(
            rows: List<List<Long>>,
            problemIndex: Int,
            operation: Operator
    ): Long {
        return rows.map { row -> row[problemIndex] }.fold(operation.identity()) {
                accProblem,
                rowValue ->
            operation.performOperation(accProblem, rowValue)
        }
    }
}

fun main(args: Array<String>) {
    val inputPath = args.parseInputPath()
    val worksheet = Files.readAllLines(inputPath)

    println("Result: ${Part1.getResult(worksheet)}")
}
