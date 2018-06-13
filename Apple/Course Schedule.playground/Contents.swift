//: Course Schedule
/*
 There are a total of n courses you have to take, labeled from 0 to n - 1.
 
 Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]
 
 Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?
 
 For example:
 
 2, [[1,0]]
 There are a total of 2 courses to take. To take course 1 you should have finished course 0. So it is possible.
 
 2, [[1,0],[0,1]]
 There are a total of 2 courses to take. To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
 */

/*
 BFS:
 step 1: transfer prerequisites to graph matrix
 step 2: get the indegree
 step 3: push node indegree 0 into a queue
 step 4: dequeue, and update indegree --, if indegree is 0, push node into queue.
 */

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var matrix = Array(repeating: Array(repeating: 0, count: numCourses), count: numCourses)
    var indegrees = Array(repeating: 0, count: numCourses)
    
    for prerequisite in prerequisites {
        let pre = prerequisite[1]
        let next = prerequisite[0]
        if matrix[pre][next] == 0 {
            indegrees[next] += 1
        }
        matrix[pre][next] = 1
    }
    
    print(indegrees)
    print(matrix)
    
    var course = 0
    var queue = [Int]()
    for i in 0..<indegrees.count {
        if indegrees[i] == 0 {
            queue.append(i)
        }
    }
    
    print(queue)
    
    while !queue.isEmpty {
        let curCourse = queue.removeFirst()
        course += 1
        // remove current course from matrix by decress indegree
        for i in 0..<numCourses {
            if matrix[curCourse][i] != 0 {
                indegrees[i] = indegrees[i] - 1
                if indegrees[i] == 0 {
                    queue.append(i)
                }
            }
        }
    }
    
    
    return course == numCourses
}

canFinish(3, [[2,0],[2,1]])
