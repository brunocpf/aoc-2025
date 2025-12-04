lazy val root = (project in file(".")).settings(
  inThisBuild(
    List(
      organization := "com.aoc.day03",
      scalaVersion := "3.5.2"
    )
  ),
  name := "day03"
)

libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.19" % Test
libraryDependencies += "com.lihaoyi" %% "mainargs" % "0.7.7"
