package com.aoc.day03

import mainargs.{main, arg}
import scala.io.Source
import mainargs.ParserForMethods

object Part2 {
  @main
  def run(@arg(name = "input", short = 'i') inputPath: String): Unit = {
    try {
      val source = Source.fromFile(inputPath);
      val bankStrings = source.mkString.split('\n')
      val banks = bankStrings
        .map(bankStr =>
          bankStr
            .split("")
            .map(battery => battery.toInt)
            .toList
        )
        .toList

      val result = Challenge.part2(banks)
      println(s"Result: ${result}")

      source.close()
    } catch {
      case e: java.io.FileNotFoundException =>
        println(s"Error: File not found at $inputPath")
      case e: Exception =>
        println(s"An error occurred: ${e.getMessage}")
    }

  }

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args)
}
