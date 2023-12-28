#!/usr/bin/groovy
matrix = new File('input.txt').text.split("\n")
edges = matrix.collect{ it.split("-") }.collect{ [it[0],it[1]] }.unique()

nodes = []
edges.each { nodes<<it[0]; nodes<<it[1] }
nodes.unique()

adjacent = nodes.collectEntries{ [it, []] }
edges.each { adjacent[it[0]] << it[1]; adjacent[it[1]] << it[0] }

def legalNext(path, nextNodes) {
    nextNodes.findAll{ it!="start" && (it=~/[A-Z]+/ || !path.findAll{it=~/[a-z]+/}.contains(it))}
}

def visit(path) {
    if (path[-1] == "end") {
        return 1
    }
    res = legalNext(path, adjacent[path[-1]]).collect{ visit(path+it) }.flatten()
    res.isEmpty() ? 0 : res.sum()
}

println visit(["start"])
