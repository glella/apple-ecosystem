//
//  PrimesSwift.swift
//  primes
//
//  Created by Guillermo Lella on 1/30/21.
//

import Foundation

func swift_1_Thread(limit: Int) -> Int {
    var result = [Int]()
    result.append(2)
    
    var isPrime:Bool = true
    
    for x in stride(from: 3, through: limit, by: 2) {
        let sq: Int = Int(sqrt(Double(x)))
        isPrime = true

        for i in stride(from: 3, through: sq, by: 2) where x % i == 0 {
            isPrime = false
            break
        }
        if isPrime {
            result.append(x)
        }
//            Alternative way. Works but it is a tad slower
//            if x % 2 != 0 && !stride(from: 3, through: Int(sqrt(Double(x))), by: 2).contains(where: {x % $0 == 0}) {
//              result.append(x)
//            }
    }
    return result.count
}

func nIsPrime(n: Int) -> Bool {
    switch n {
    case let x where x < 2:
        return false
    case 2:
        return true
    default:
        return n % 2 != 0 && !stride(from: 3, through: Int(sqrt(Double(n))), by: 2).contains {n % $0 == 0}
    }
}

func prepSearch(limit: Int, threads: Int) -> [[Int]] {
    var range_sizes = [Int]()
    let size = limit / threads
    var reminder = limit % threads
    
    for _ in 0..<threads {
        range_sizes.append(size)
    }
    
    //Spread the reminder
    for index in range_sizes.indices {
        if reminder > 0 {
            range_sizes[index] += 1
            reminder -= 1
        }
    }
    
    var vectors = [[Int]]()
    var min = 1
    var max: Int
    
    for i in range_sizes {
        max = min + i
        //vectors.append(Array(min..<max))
        vectors.append(Array((min..<max).filter { $0 % 2 == 1 })) // Sacar pares de la lista
        min = max
    }
    //print(vectors)
    return vectors
}

func swift_n_threads(limit: Int, threads: Int) -> Int {
    var result = [Int]()
    let vectors = prepSearch(limit: limit, threads: threads)
    result.append(2)
    // Approach #1 - Semaphores & Locks - It works - slower because of locks?
    let semaphore = DispatchSemaphore(value: threads)
    let queue = OperationQueue()
    let lock = NSLock()
    for segment in vectors {
        queue.addOperation {
            for i in segment {
                if nIsPrime(n: i) {
                    lock.lock()
                    result.append(i)
                    lock.unlock()
                }
            }
            semaphore.signal()
        }
        semaphore.wait()
    }
    queue.waitUntilAllOperationsAreFinished()
    
    return result.count
}