//: Flood Fill
/*
 An image is represented by a 2-D array of integers, each integer representing the pixel value of the image (from 0 to 65535).
 
 Given a coordinate (sr, sc) representing the starting pixel (row and column) of the flood fill, and a pixel value newColor, "flood fill" the image.
 
 To perform a "flood fill", consider the starting pixel, plus any pixels connected 4-directionally to the starting pixel of the same color as the starting pixel, plus any pixels connected 4-directionally to those pixels (also with the same color as the starting pixel), and so on. Replace the color of all of the aforementioned pixels with the newColor.
 
 At the end, return the modified image.
 */

import Foundation


// use DFS, look at left, right, up, and down.
// return when:
// (1) the color is different
// (2) exceed the bound

func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
    if image.count == 0 {
        return image
    }
    var res = image
    let startColor = res[sr][sc]
    let r = image.count
    let c = image[0].count
    
    if startColor == newColor {
        return res
    }
    
    dfs(sr, sc, r, c, newColor, startColor, &res)
    return res
}

private func dfs(_ sr: Int,
                 _ sc: Int,
                 _ r: Int,
                 _ c: Int,
                 _ newColor: Int,
                 _ startColor: Int,
                 _ res: inout [[Int]]) {
    
    guard sr < r && sr >= 0, sc < c && sc >= 0, res[sr][sc] == startColor else {
        return
    }
    
    res[sr][sc] = newColor
    
    dfs(sr - 1, sc, r, c, newColor, startColor, &res)
    dfs(sr + 1, sc, r, c, newColor, startColor, &res)
    dfs(sr, sc - 1, r, c, newColor, startColor, &res)
    dfs(sr, sc + 1, r, c, newColor, startColor, &res)
}

let image = [[0,0,0],[0,0,0]]

floodFill(image, 0, 0, 2)

