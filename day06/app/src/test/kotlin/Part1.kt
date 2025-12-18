import kotlin.test.Test
import kotlin.test.assertEquals

class Part1Test {
    @Test
    fun test() {
        val worksheet = listOf("123 328  51 64 ",
                               " 45 64  387 23 ",
                               "  6 98  215 314",
                               "*   +   *   +  ",)

        val result = Part1.getResult(worksheet)
        assertEquals(4277556L, result)
    }
}
