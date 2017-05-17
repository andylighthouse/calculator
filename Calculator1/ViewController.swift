//
//  ViewController.swift
//  Calculator1
//
//  Created by Andy Li on 2016-03-13.
//  Copyright © 2016 Andy Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingNumber = false

    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!

        
        if userIsInTheMiddleOfTypingNumber == true{
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }

         print("digit = \(digit)")
    }
    
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        
        switch operation {
        case "×": performOperation { $0 * $1 }    //( { (op1, op2)  in return op1 * op2 })
        case "÷": performOperation { $0 / $1 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation1 { sqrt($0)}
        default: break
        }
        
    }
    
    
    func performOperation(_ operation: (Double, Double) -> Double) {
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation1(_ operation: ( Double) -> Double) {
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = [Double]() //Array<Double>()
   
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
   
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
            
        }
    }
}

