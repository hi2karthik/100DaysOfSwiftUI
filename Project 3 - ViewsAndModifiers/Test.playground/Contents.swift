import UIKit


func makeA() -> some Equatable { "A" }
func makeOne() -> some Equatable { 1 }

let a = makeA()
let anotherA = makeA()
let one = makeOne()
var x: Int = 0

print(a == anotherA)
//print(a == one)

//x = makeOne()

func makeOneOrA(_ isOne: Bool) -> some Equatable {
    isOne ? 1 : "A"
}

