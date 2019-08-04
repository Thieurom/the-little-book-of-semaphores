/*:
 ## Mutex
 Add semaphores to the following example to enforce mutual exclu- sion to the shared variable count.
 ### Thread A
 `count = count + 1`

 ### Thread B
 `count = count + 1`
 */

import Foundation

var count = 100

let queueA = DispatchQueue(label: "com.thieurom.a", attributes: .concurrent)
let queueB = DispatchQueue(label: "com.thieurom.a", attributes: .concurrent)
let mutex = DispatchSemaphore(value: 1)

print("Initial value of `count`: \(count)")

let group = DispatchGroup()

queueA.async(group: group) {
    mutex.wait()
    print("Increment `count` by 1.")

    count += 1
    mutex.signal()
}

queueB.async(group: group) {
    mutex.wait()
    print("Increment `count` by 1.")

    count += 1
    mutex.signal()
}

group.notify(queue: .main) {
    print("Final value of `count`: \(count)")
}
