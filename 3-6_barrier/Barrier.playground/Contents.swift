import Foundation

let maxCount = 5
let mutex = DispatchSemaphore(value: 1)
let barrier = DispatchSemaphore(value: 0)

let queues: [DispatchQueue] = (1...maxCount).map { DispatchQueue(label: "com.thieurom.queue-\($0)", attributes: .concurrent) }

var counts = maxCount

queues.forEach { (queue) in
    queue.async {
        mutex.wait()
        counts -= 1
        mutex.signal()

        print("rendezvous")

        if counts == 0 {
            barrier.signal()
        }

        barrier.wait()
        barrier.signal()

        print("critical point")
    }
}
