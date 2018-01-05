//: Playground - noun: a place where people can play

import UIKit

var studentName : String?
var studentLastname : String?
var studentGPA : Double?
studentName = "Worasit"
studentLastname = "Choochaiwattana"
print("Your Name : \(studentName!) \(studentLastname!)")
studentGPA = 3.99
if let a = studentGPA{
    print(a)
}
else{
    print("student GPA is not initialized")
}
