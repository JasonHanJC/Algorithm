//: Spiral Matrix

func spiralMatrix(_ n: Int, _ m: Int) {
    
    var rowBegin = 1, rowEnd = n, colBegin = 1, colEnd = m

    while rowBegin <= rowEnd && colBegin <= colEnd {
        
        if  colBegin <= colEnd {
            // go right
            for i in colBegin...colEnd {
                print("\(rowBegin), \(i)")
            }
        }
        rowBegin += 1
        
        if  rowBegin <= rowEnd {
            // go down
            for i in rowBegin...rowEnd {
                print("\(i), \(colEnd)")
            }
        }
        colEnd -= 1
        
        // go left
        if  rowBegin <= rowEnd {
            var i = colEnd
            while i >= colBegin {
                print("\(rowEnd), \(i)")
                i -= 1
            }
        }
        
        rowEnd -= 1
        
        // go up
        if  colBegin <= colEnd {
            var j = rowEnd
            while j >= rowBegin {
                print("\(j), \(colBegin)")
                j -= 1
            }
        }
        colBegin += 1
    }
}

spiralMatrix(1, 1)



for i in 0...1 {
    print(i)
}

