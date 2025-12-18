import java.nio.file.Path
import kotlin.io.path.exists

fun Array<String>.parseInputPath(): Path {
    val index = indexOf("--input")
    require(index >= 0 && index + 1 < size) { "Usage: --input <path>" }

    val path = Path.of(this[index + 1])
    require(path.exists()) { "Input file does not exist: $path" }

    return path
}
