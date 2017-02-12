//: Playground - noun: a place where people can play

import UIKit

//conccurenly performs work items
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

//wait for the two finnctions to complete
sleep(2)

//two concurrent loops on different QoS global queues. A background one and UI one
DispatchQueue.global(qos: .background).async {
    for i in 1...5 {
        print("global async \(i)")
    }
}
DispatchQueue.global(qos: .userInteractive).async {
    for i in 1...5 {
        print("global async 2 \(i)")
    }
}

//wait for the two finnctions to complete
sleep(2)


//creating a custom dispatch queue
let dq = DispatchQueue(label: "my dispatch queue")
dq.async {
    print ("hello")
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
//create the dispatch work item
var dwi2:DispatchWorkItem?
dwi2 = DispatchWorkItem {
    for i in 1...5 {
        print("\(dwi2?.isCancelled)")
        if (dwi2?.isCancelled)!{
            break
        }
        sleep(1)
        print("DispatchWorkItem 2: \(i)")
    }
}
//submit the work item to the default global queue
DispatchQueue.global().async(execute: dwi2!)

//cancelling the task after 3 seconds
DispatchQueue.global().async{
    sleep(3)
    dwi2?.cancel()
}

sleep(5)


//DispatchWorkItem notify example
let dwi3 = DispatchWorkItem {
    print("start DispatchWorkItem")
    sleep(2)
    print("end DispatchWorkItem")
}
//this block will be executed on a the siqpatch queue 'dq' when dwi3 completes
let myDq = DispatchQueue(label: "A custom dispatch queue")
dwi3.notify(queue: myDq) {
    print("notify")
}
DispatchQueue.global().async(execute: dwi3)

sleep(4)

//dispatch group allows to track the completion of a set of blocks
let dispatchWorkItem = DispatchWorkItem{
    print("work item start")
    sleep(1)
    print("work item end")
}

let dg = DispatchGroup()
//submiy work items to the group
let dispatchQueue = DispatchQueue(label: "custom dq")
dispatchQueue.async(group: dg) {
    print("block start")
    sleep(2)
    print("block end")
}
DispatchQueue.global().async(group: dg, execute: dispatchWorkItem)
//print message when all blocks in the group finish
dg.notify(queue: DispatchQueue.global()) {
    print("dispatch group over")
}

//add some delay to end the playground because we have a lot of async work ^^
sleep(3)

//A semaphore that blocks execution until it recieves at least one signal -> value = 0
let semaphore = DispatchSemaphore(value: 0)
DispatchQueue.global().async {
    print("waiting for at least one signal")
    //wait for a signal
    semaphore.wait()
    print("At least one signal has been received")
}

DispatchQueue.global().async {
    sleep(2)
    print("calling signal")
    //send the signal
    semaphore.signal()
}

sleep(3)


//We can specify a timeout for the wait function
let sem = DispatchSemaphore(value: 0)
DispatchQueue.global().async {
    print("waiting for at least one signal for 1 second")
    //wait for a signal
    let res = sem.wait(timeout: DispatchTime.now() + 1)
    if(res == .timedOut){
        print("wait timed out")
    }else{
        print("At least one signal has been received")
    }
}

DispatchQueue.global().async {
    sleep(3)
    print("calling signal")
    //send the signal
    sem.signal()
}

sleep(3)
