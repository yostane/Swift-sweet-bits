//: Playground - noun: a place where people can play

import UIKit


DispatchQueue.concurrentPerform(iterations: 5) { (i) in
    print(i)
}

//two concurrent loops
DispatchQueue.global().async {
    for i in 1...5 {
        print("global async \(i)")
    }
}
DispatchQueue.global().async {
    for i in 1...5 {
        print("global async 2 \(i)")
    }
}

//does not work on playgrounds
DispatchQueue.main.async {
    for i in 1...5 {
        print("main async \(i)")
    }
}

//a dispatch work item encapsulates work
let dwi = DispatchWorkItem {
    for i in 1...5 {
        print("DispatchWorkItem \(i)")
    }
}
//perform on the current thread
dwi.perform()
//perpform on the global queue
DispatchQueue.global().async(execute: dwi)


//Handling calcellation is a bit ugly
var dwi2:DispatchWorkItem?
dwi2 = DispatchWorkItem {
    for i in 1...5 {
        print("\(dwi2?.isCancelled)")
        sleep(1)
        print("DispatchWorkItem 2: \(i)")
    }
}
DispatchQueue.global().async(execute: dwi2!)
DispatchQueue.global().async{
    sleep(3)
    dwi2?.cancel()
}

//dispatch group allows to track the completion of a set of blocks
let dg = DispatchGroup()
//submiy work items to the group
DispatchQueue.global().async(group: dg, execute: dwi)
DispatchQueue.global().async(group: dg, execute: dwi2!)
//print message when all blocks in the group finish
dg.notify(queue: DispatchQueue.global()) {
    print("dispatch group over")
}

//add some delay to end the playground because we have a lot of async work ^^
sleep(10)


