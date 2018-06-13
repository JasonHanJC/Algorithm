//: Reverse Integer
/*
 x = 123, return 321
 x = -123, return -321
 */

let maxInt = Int.max

func reverseInteger(_ num: Int) -> Int {
    var res = 0
    var num = num
    while num != 0 {
        let remaining = num % 10
        
        let wrapMult = res.multipliedReportingOverflow(by: 10)
        guard !wrapMult.overflow else {
            return 0
        }
        
        let wrapAdd = wrapMult.partialValue.addingReportingOverflow(remaining)
        guard !wrapAdd.overflow else {
            return 0
        }
        
        res = wrapAdd.partialValue
        num /= 10
    }
    return res
}

print(reverseInteger(-321))
