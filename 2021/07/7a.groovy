#!/usr/bin/groovy
crabs = new File('input.txt').text.split(",").collect { it as Integer }

println ((crabs.min()..crabs.max())
          .collect { linePos -> crabs.collect{ crabPos -> Math.abs(crabPos - linePos) }.sum() }
          .min())
