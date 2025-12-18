enum class Operator {
    ADD {
        override fun performOperation(x: Long, y: Long) = x + y
        override fun identity() = 0L
    },
    MULT {
        override fun performOperation(x: Long, y: Long) = x * y
        override fun identity() = 1L
    };

    abstract fun performOperation(x: Long, y: Long): Long
    abstract fun identity(): Long

    companion object {
        fun getOperator(char: Char) =
                when (char) {
                    '+' -> ADD
                    '*' -> MULT
                    else -> MULT
                }
    }
}
