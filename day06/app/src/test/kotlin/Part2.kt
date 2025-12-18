import kotlin.test.Test
import kotlin.test.assertEquals

class Part2Test {
    @Test
    fun test() {
        val worksheet = listOf("123 328  51 64 ",
                               " 45 64  387 23 ",
                               "  6 98  215 314",
                               "*   +   *   +  ",)

        val result = Part2.getResult(worksheet)
        assertEquals(3263827L, result)
    }
}
