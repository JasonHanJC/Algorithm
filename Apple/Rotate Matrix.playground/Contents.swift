//: Rotate nxn matrix by 90 clockwise

func rotateMatrix(_ m: inout [[Int]], _ n: Int) {
    
    // flip 1
    for i in 0..<n/2 {
        let startRow = i
        for j in 0...n - 1 {
            let temp = m[startRow][j]
            m[startRow][j] = m[n - startRow - 1][j]
            m[n - startRow - 1][j] = temp
        }
    }
    
    // flip 2
    for i in 0...n-1 {
        for j in i...n-1 {
            let temp = m[i][j]
            m[i][j] = m[j][i]
            m[j][i] = temp
        }
    }
}

var m = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
rotateMatrix(&m, 3)
