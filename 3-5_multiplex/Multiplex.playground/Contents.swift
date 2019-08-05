/*:
 ## Multiplex
 Add semaphores to the following example to enforce mutual exclusion to the shared variable count. It allows multiple threads to run in the critical section at the same time, but it enforces an upper limit on the number of concurrent threads. In other words, no more than n threads can run in the critical section at the same time.

 `count = count + 1`
 */

import Foundation

let threadCount = 5  // The number of worker threads
let MAX_THREAD = 2   // The maximum number or concurrent threads
let multiplex = DispatchSemaphore(value: MAX_THREAD)

let group = DispatchGroup()

print("Start working ...")

for i in 1...threadCount {
    let queue = DispatchQueue(label: "com.thieurom.queue\(i)", attributes: .concurrent)

    queue.async(group: group) {
        multiplex.wait()

        // critical section here
        // ...

        multiplex.signal()
    }
}

group.notify(queue: .main) {
    print("All work finished.")
}
