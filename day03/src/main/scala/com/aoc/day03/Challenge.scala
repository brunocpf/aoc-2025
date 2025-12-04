package com.aoc.day03

import scala.collection.mutable.ListBuffer

object Challenge {
  def part1(banks: List[List[Int]]): Int = {
    var totalJoltage = 0

    for (bank <- banks) {
      var maxJoltage = findLargestJoltage(bank, 2).toInt

      totalJoltage += maxJoltage
    }

    return totalJoltage
  }

  def part2(banks: List[List[Int]]): Long = {
    var totalJoltage = 0L

    for (bank <- banks) {
      var maxJoltage = findLargestJoltage(bank, 12)

      totalJoltage += maxJoltage
    }

    return totalJoltage
  }

  def findLargestJoltage(bank: List[Int], maxDigits: Int): Long = {
    var offBatteries = 0
    val joltsInLargestOrder = new ListBuffer[Int]()

    for (batteryJoltage <- bank) {
      while (
        offBatteries < (bank.length - maxDigits)
        && joltsInLargestOrder.length > 0
        && joltsInLargestOrder.last < batteryJoltage
      ) {
        joltsInLargestOrder.remove(joltsInLargestOrder.length - 1)
        offBatteries += 1
      }
      joltsInLargestOrder.addOne(batteryJoltage)
    }

    var value = 0L
    for (i <- 0 to maxDigits - 1) {
      value = value * 10 + joltsInLargestOrder(i)
    }

    return value
  }
}
