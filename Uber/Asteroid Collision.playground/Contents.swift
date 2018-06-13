//: Playground - noun: a place where people can play
/*
 We are given an array asteroids of integers representing asteroids in a row.
 
 For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.
 
 Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.
 
 Example 1:
 Input:
 asteroids = [5, 10, -5]
 Output: [5, 10]
 Explanation:
 The 10 and -5 collide resulting in 10.  The 5 and 10 never collide.
 Example 2:
 Input:
 asteroids = [8, -8]
 Output: []
 Explanation:
 The 8 and -8 collide exploding each other.
 Example 3:
 Input:
 asteroids = [10, 2, -5]
 Output: [10]
 Explanation:
 The 2 and -5 collide resulting in -5.  The 10 and -5 collide resulting in 10.
 Example 4:
 Input:
 asteroids = [-2, -1, 1, 2]
 Output: [-2, -1, 1, 2]
 Explanation:
 The -2 and -1 are moving left, while the 1 and 2 are moving right.
 Asteroids moving the same direction never meet, so no asteroids will meet each other.
 */


// + -
// use stack
// if stack is empty or current asteroid is positive, add asteroid into stack
// if asteroid is negtive, if stack top is negtive, push current asteroid into stack
//

// Asteroid Collision

func asteroidCollision(_ asteroids: [Int]) -> [Int] {
    if asteroids.count == 0 {
        return asteroids
    }
    
    // make a stack
    var stack: [Int] = [Int]()
    
    for asteroid in asteroids {
        while let top = stack.last, top > 0, asteroid < 0, top < -asteroid {
            stack.removeLast()
        }
        if stack.isEmpty || stack.last! < 0 || asteroid > 0 {
            stack.append(asteroid)
        } else if asteroid < 0, stack.last! == -asteroid {
            stack.removeLast()
        }
    }
    
    return stack
}

asteroidCollision([1,-2,-2,-2])
