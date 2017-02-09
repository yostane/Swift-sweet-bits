//: Playground - noun: a place where people can play

import UIKit

/**
 We can define the guard statement is an if statement that has only an else block.
 
 Let's the how much useful is guard statement through an example.
 
 Suppose we declare a function that takes an optional argument. In the body of that function we may need to test if the optional argument is not actually nil.
 
 One way to do is by using an if arg == nil test. in the else block, we can safely unwrap the argument. The code looks like this
 */

func handleNilWithoutGuardMethod1(str: String?){
    if str == nil {
        print("str is nil")
        return
    }
    let s = str!
    print("s in not nill here \(s)")
    //do other things here
}

handleNilWithoutGuardMethod1(str: nil)
handleNilWithoutGuardMethod1(str: "hello")

/**
 The inconvient of this code is that we have to add a line of code that unwraps the argument
 
 We can avoid this using and if let s = arg statement like this.
 */
func handleNilWithoutGuardMethod2(str: String?){
    if let s = str {
        print("s in not nil here \(s)")
        //do other things here
    }else{
        print("str is nil")
    }
}
handleNilWithoutGuardMethod2(str: nil)
handleNilWithoutGuardMethod2(str: "hello")

/**
 However, the problem here is that the if block can be very large and will make the else part harder to reach and understand.
 
 The guard statement comes to the rescue. It combines the advnatages of the two previous examples. Here is how to write the prevous exmaples using guard. It tries to unwrap the variable, if this fails, we enter the else statement.
 */

func guardMe(str: String?){
    guard let s = str else{
        print("str is nil")
        return
    }
    print("s in not nil here \(s)")
    //do other things here
}

guardMe(str: nil)
guardMe(str: "hello")

/*
 As you can see, we isolate the case where the optionnal is nil first. After the guard statment, the unwrapped variable is available for use.
 
 Another advantage of guard is that the compiler forces you to add a return or break statement to the else block
 
 You can also add conditions to the guard statmement like these examples. If any condition fails, we enter the else statement.
 */

func guardMe2(str: String?){
    guard let s = str, s == "hello" else{
        print("str is nil or not equal to hello")
        return
    }
    print("s is equal to hello \(s)")
    //do other things here
}

guardMe2(str: nil)
guardMe2(str: "aaa")
guardMe2(str: "hello")

func guardMe3(str: String?, value: Int?){
    guard let s = str, s == "hello", let v = value, v < 100 else{
        print("str is nil or not equal to hello or value is nil or value is >= 100")
        return
    }
    print("s is equal to hello \(s) and v is < 100 and is not nil")
    //do other things here
}


guardMe3(str: nil, value: 5)
guardMe3(str: "aaa", value: 5)
guardMe3(str: "hello", value: 200)
guardMe3(str: "hello", value: nil)
guardMe3(str: "hello", value: 5)

/*
 This short article illustrated through examples the usefullness of the guard statement in swift 3
 */


/*
references:
https://ericcerney.com/swift-guard-statement/
*/
