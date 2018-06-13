//: Direct graph


class Graph {
    
    class Vertex {
        
        var val: String?
        var edges: [Edge] = [Edge]()
        
        init(val: String? = nil) {
            self.val = val
        }
    }
    
    class Edge {
        
        var destination: Vertex?
        var weight: Int
        
        init(destination: Vertex? = nil, weight: Int = 0) {
            self.destination = destination
            self.weight = weight
        }
    }
    
    var canvas :[Vertex]
    
    init() {
        canvas = [Vertex]()
    }
    
    func addVertex(val: String) -> Vertex {
        
        let childVertex = Vertex(val: val)
        
        canvas.append(childVertex)
        
        return childVertex
    }
    
    func addEdge(from: Vertex, to: Vertex, weight: Int) {
        
        let newEdge = Edge(destination: to, weight: weight)
        
        from.edges.append(newEdge)
    }
    
    func detectCycle() -> Bool {
        guard canvas.count != 0 else {
            return false
        }
        
        var res = false
        for vertex in canvas {
            var visited = [Vertex]()
            res = dfsHelper(vertex, &visited)
        }
        
        return res
    }
    
    func dfsHelper(_ v: Vertex, _ visited: inout [Vertex]) -> Bool {
        
        if visited.contains(where: { (vertex) -> Bool in
            vertex.val == v.val
        }) {
            return true
        }
        
        visited.append(v)
        for e in v.edges {
            if dfsHelper(e.destination!, &visited) {
                return true
            }
        }
        visited.removeLast()
        
        return false
    }
}

let graph = Graph()
let vertex1 = graph.addVertex(val: "100")
graph.addEdge(from: vertex1, to: vertex1, weight: 0)

graph.detectCycle()


