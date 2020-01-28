/*:
## Barrier
Generalize the rendezvous solution. Every thread should run the following code:
```
    rendezvous
    critical point
```
The synchronization requirement is that no thread executes critical point until after all threads have executed rendezvous.
You can assume that there are n threads and that this value is stored in a variable, n, that is accessible from all threads.
When the first n − 1 threads arrive they should block until the nth thread arrives, at which point all the threads may proceed.
*/

import Foundation

let maxCount = 5
let mutex = DispatchSemaphore(value: 1)
let barrier = DispatchSemaphore(value: 0)

let queues: [DispatchQueue] = (1...maxCount).map { DispatchQueue(label: "com.thieurom.queue-\($0)", attributes: .concurrent) }

var counts = maxCount

queues.forEach { (queue) in
    queue.async {
        print("\(queue.label.dropFirst(13)) arrives to rendezvous")

        mutex.wait()
        counts -= 1
        mutex.signal()

        if counts == 0 {
            barrier.signal()
        }

        barrier.wait()
        barrier.signal()

        print("\(queue.label.dropFirst(13)) accesses critical point")
    }
}
