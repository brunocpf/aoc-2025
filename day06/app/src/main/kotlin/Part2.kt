import java.nio.file.Files

object Part2 {
    fun getResult(worksheet: List<String>): Long {
        val operators = parseOperators(worksheet.last())
        val numberLines = worksheet.dropLast(1)
        val splitLines = splitNumberLines(numberLines)

        return operators
                .foldIndexed(0L to 0) { problemIndex, acc, operator ->
                    val (accSum, currentCharacterIndex) = acc
                    val operation = Operator.getOperator(operator)
                    val maxDigitsForProblem = maxDigitsForProblem(splitLines, problemIndex)
                    val lastCharacterIndexForProblem = currentCharacterIndex + maxDigitsForProblem
                    val characterRange = currentCharacterIndex until lastCharacterIndexForProblem
                    val currentProblem = sliceProblem(numberLines, characterRange)

                    val result = aggregateProblem(currentProblem, maxDigitsForProblem, operation)
                    Pair(accSum + result, lastCharacterIndexForProblem + 1)
                }
                .first
    }

    private fun parseOperators(operatorLine: String): List<Char> =
            operatorLine.trim().split(Regex("\\s+")).map { it.single() }

    private fun splitNumberLines(numberLines: List<String>): List<List<String>> =
            numberLines.map { line -> line.trim().split(Regex("\\s+")) }

    private fun maxDigitsForProblem(splitLines: List<List<String>>, problemIndex: Int): Int =
            splitLines.maxOf { line -> line[problemIndex].length }

    private fun sliceProblem(numberLines: List<String>, characterRange: IntRange): List<String> =
            numberLines.map { line -> line.slice(characterRange) }

    private fun aggregateProblem(
            currentProblem: List<String>,
            maxDigitsForProblem: Int,
            operation: Operator
    ): Long {
        return (0 until maxDigitsForProblem).fold(operation.identity()) { accProblem, digitPosition
            ->
            val rowValue =
                    currentProblem
                            .map { line -> line[digitPosition].toString().trim() }
                            .joinToString("")
                            .toLongOrNull()
                            ?: operation.identity()
            operation.performOperation(accProblem, rowValue)
        }
    }
}

fun main(args: Array<String>) {
    val inputPath = args.parseInputPath()
    val worksheet = Files.readAllLines(inputPath)

    println("Result: ${Part2.getResult(worksheet)}")
}
