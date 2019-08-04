
import Foundation

/*:
 ## Rendezvous

 Given this code:
 ```
    Thread A
    ------------
    statement a1
    statement a2
 ```

 ```
    Thread B
    ------------
    statement b1
    statement b2
 ```
 We want to guarantee that a1 happens before b2 and b1 happens before a2.
 */

func main() {
    let aStarted = DispatchSemaphore(value: 0)
    let bStarted = DispatchSemaphore(value: 0)

    let queueA = DispatchQueue(label: "com.thieurom.a", attributes: .concurrent)
    let queueB = DispatchQueue(label: "com.thieurom.b", attributes: .concurrent)

    queueA.async {
        print("statement A1 run")
        aStarted.signal()

        bStarted.wait()
        print("statement A2 run")
    }

    queueB.async {
        print("statement B1 run")
        bStarted.signal()

        aStarted.wait()
        print("statement B2 run")
    }
}

main()
