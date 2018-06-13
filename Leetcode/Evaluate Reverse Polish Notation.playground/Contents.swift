//: Evaluate Reverse Polish Notation

/*
 Evaluate the value of an arithmetic expression in Reverse Polish Notation.
 
 Valid operators are +, -, *, /. Each operand may be an integer or another expression.
 
 Some examples:
 ["2", "1", "+", "3", "*"] -> ((2 + 1) * 3) -> 9
 ["4", "13", "5", "/", "+"] -> (4 + (13 / 5)) -> 6
 */


func calculate(_ op: String, _ a: Int, _ b: Int) -> Int {
    if op == "+" {
        return a + b
    } else if op == "-" {
        return a - b
    } else if op == "*" {
        return a * b
    } else {
        return a / b
    }
}


func evalRPN(_ tokens: [String]) -> Int {
    if tokens.count == 0 {
        return 0
    }
    
    var stack = [Int]()
    
    for i in 0..<tokens.count {
        // check string is a number
        if let num = Int(tokens[i]) {
            stack.append(num)
        } else {
            let b = stack.removeLast()
            let a = stack.removeLast()
            let temp = calculate(tokens[i], a, b)
            stack.append(temp)
        }
    }
    return stack.removeLast()
}

// evalRPN(["4", "13", "5", "/", "+"])
