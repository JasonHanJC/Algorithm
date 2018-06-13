//: Paint House
/*
 There are a row of n houses, each house can be painted with one of the three colors: red, blue or green. The cost of painting each house with a certain color is different. You have to paint all the houses such that no two adjacent houses have the same color.
 
 The cost of painting each house with a certain color is represented by a n x 3 cost matrix. For example, costs[0][0] is the cost of painting house 0 with color red; costs[1][2] is the cost of painting house 1 with color green, and so on... Find the minimum cost to paint all houses.
 */

func minCosts(_ costs: [[Int]]) -> Int {
    if costs.count == 0 || costs[0].count == 0 {
        return 0
    }
    
    var costs = costs
    var i = 1
    let size = costs.count
    
    while i < size {
        // store the min cost from house 0 - i
        let minWithRed = min(costs[i - 1][1], costs[i - 1][2])
        costs[i][0] += minWithRed
        let minWithBlue = min(costs[i - 1][0], costs[i - 1][2])
        costs[i][1] += minWithBlue
        let minWithYellow = min(costs[i - 1][0], costs[i - 1][1])
        costs[i][2] += minWithYellow
        
        i += 1
    }
    
    let r = costs[size - 1][0]
    let b = costs[size - 1][1]
    let y = costs[size - 1][2]
    return min(r, b, y)
}

let costs: [[Int]] = [[1,2,3], [1,2,3], [1,2,3]]
minCosts(costs)
