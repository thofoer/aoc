#!/usr/bin/groovy
input = new File('input.txt').text.split("\n")
edges = input.collect{ it.split("-") }.collect{ [it[0],it[1]] }.unique()

nodes = []
edges.each { nodes<<it[0]; nodes<<it[1] }
nodes.unique()

adjacent = nodes.collectEntries{ [it, []] }
edges.each { adjacent[it[0]] << it[1]; adjacent[it[1]] << it[0] }

def nextPossibleCaves(path, nextNodes) {
    allCaves = nextNodes - "start"
    
    smallCaves   = path.findAll{ it=~/[a-z]+/ }
    cavesByCount = smallCaves.unique(false).groupBy{ smallCaves.count(it) }

    cavesByCount[2] ? allCaves - cavesByCount[1] - cavesByCount[2] : allCaves
}

def visit(path) {
    path[-1] == "end" ? 1 : nextPossibleCaves(path, adjacent[path[-1]]).collect{ visit(path+it) }.sum() ?: 0
}

println visit(["start"])
