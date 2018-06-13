//: Employee Importance
/*
 You are given a data structure of employee information, which includes the employee's unique id, his importance value and his direct subordinates' id.
 
 For example, employee 1 is the leader of employee 2, and employee 2 is the leader of employee 3. They have importance value 15, 10 and 5, respectively. Then employee 1 has a data structure like [1, 15, [2]], and employee 2 has [2, 10, [3]], and employee 3 has [3, 5, []]. Note that although employee 3 is also a subordinate of employee 1, the relationship is not direct.
 
 Now given the employee information of a company, and an employee id, you need to return the total importance value of this employee and all his subordinates.
 
 Example 1:
 Input: [[1, 5, [2, 3]], [2, 3, []], [3, 3, []]], 1
 Output: 11
 */

// Create Employee struct

class Employee {
    var uid: Int
    var importance: Int
    var subordinates: [Int]
    
    init(_ uid: Int, _ importance: Int, _ subordinates: [Int]) {
        self.uid = uid
        self.importance = importance
        self.subordinates = subordinates
    }
}

func getImportance(_ employees: [Employee], _ uid: Int) -> Int {
    var res = 0
    if employees.count == 0 {
        return res
    }
    
    // dictionary
    var dict = [Int : Employee]()
    
    for employee in employees {
        dict[employee.uid] = employee
    }
    
    // dfs queue
    var stack = [Employee]()
    
    guard let emp = dict[uid] else {
        return res
    }
    
    stack.append(emp)
    
    while !stack.isEmpty {
        let current = stack.removeLast()
        res += current.importance
        for subId in current.subordinates {
            if let sub = dict[subId] {
                stack.append(sub)
            }
        }
    }
    return res
}
