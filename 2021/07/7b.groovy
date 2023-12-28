#!/usr/bin/groovy
crabs = new File('input.txt').text.split(",").collect { it as Integer }

println ((crabs.min()..crabs.max())
          .collect { linePos -> crabs.collect{ crabPos -> dist = Math.abs(crabPos - linePos); (dist**2+dist)/2 }.sum() }
          .min())
