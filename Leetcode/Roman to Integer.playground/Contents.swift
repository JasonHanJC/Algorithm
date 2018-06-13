//: Roman to Integer
/*
 Given a roman numeral, convert it to an integer.
 
 Input is guaranteed to be within the range from 1 to 3999.
 
 { 'I' , 1 },
 { 'V' , 5 },
 { 'X' , 10 },
 { 'L' , 50 },
 { 'C' , 100 },
 { 'D' , 500 },
 { 'M' , 1000 }
 */

func romanToInteger(_ s: String) -> Int {
    
    if s.count == 0 {
        return 0
    }
    
    var dict = [Character : Int]()
    dict["I"] = 1
    dict["V"] = 5
    dict["X"] = 10
    dict["L"] = 50
    dict["C"] = 100
    dict["D"] = 500
    dict["M"] = 1000
    
    let chars = Array(s)
    var i = chars.count - 1
    var pre = dict[chars[i]]!
    var res = 0
    while i >= 0 {
        let cur = dict[chars[i]]!
        if cur >= pre {
            res += cur
        } else {
            res -= cur
        }
        pre = cur
        i -= 1
    }
    
    return res
}

romanToInteger("XIX")
