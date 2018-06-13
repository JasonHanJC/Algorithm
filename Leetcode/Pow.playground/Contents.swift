//: Pow
// can n be nagetive??
func myPow(_ x: Double, _ n: Int) -> Double {
    if n == 0 {
        return 1.0
    }
    
    var n = n
    var x = x
    // check nagetive
    if n < 0 {
        n = -n
        x = 1.0 / x
    }
    
    let remain = n % 2
    let temp = myPow(x, n/2)
    if remain == 0 {
        return temp * temp
    } else {
        return x * temp * temp
    }
}

myPow(0.00001
    ,2147483647)
