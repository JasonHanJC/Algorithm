// Create a generic queue
struct Queue<T> {
    
    fileprivate var store = [T]()
    
    var isEmpty: Bool {
        return store.isEmpty
    }
    
    var front: T? {
        return store.first
    }
    
    mutating func enqueue(_ element:T) {
        store.append(element)
    }
    
    mutating func dequeue() -> T? {
        if store.isEmpty {
            return nil
        } else {
            return store.removeFirst()
        }
    }
}
