/*
 In this problem, a tree is an undirected graph that is connected and has no cycles.
 
 The given input is a graph that started as a tree with N nodes (with distinct values 1, 2, ..., N), with one additional edge added. The added edge has two different vertices chosen from 1 to N, and was not an edge that already existed.
 
 The resulting graph is given as a 2D-array of edges. Each element of edges is a pair [u, v] with u < v, that represents an undirected edge connecting nodes u and v.
 
 Return an edge that can be removed so that the resulting graph is a tree of N nodes. If there are multiple answers, return the answer that occurs last in the given 2D-array. The answer edge [u, v] should be in the same format, with u < v
 */
// union find
func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
    var parent = Array(repeating: 0, count: 10)
    for i in 0...parent.count - 1 {
        parent[i] = i
    }
    
    for edge in edges {
        let f = edge[0], t = edge[1]
        if find(&parent, f) == find(&parent, t) {
            return edge
        }
        else {
            parent[find(&parent, f)] = find(&parent, t)
        }
    }
    
    print(parent)
    
    return [Int]()
}

func find(_ parent: inout [Int], _ f: Int) -> Int {
    if f != parent[f] {
        parent[f] = find(&parent, parent[f])
    }
    return parent[f]
}

findRedundantConnection([[1,2], [2,3], [3,4], [1,4], [1,5]])
