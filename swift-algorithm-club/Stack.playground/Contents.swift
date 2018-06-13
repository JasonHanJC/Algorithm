// Make a generic stack

struct Stack<T> {
    
    fileprivate var store = [T]()
    
    var isEmpty: Bool {
        return store.isEmpty
    }
    
    var top: T? {
        return store.last
    }
    
    var count: Int {
        return store.count
    }
    
    mutating func push(_ element: T) {
        store.append(element)
    }
    
    mutating func pop() -> T? {
        if store.isEmpty {
            return nil
        } else {
            // removeLast() is not return an optional item
            return store.removeLast()
        }
    }
    
    func peek() -> T? {
        return store.last
    }
}
