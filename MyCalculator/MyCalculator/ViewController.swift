//
//  ViewController.swift
//  MyCalculator
//
//  Created by 陈睿 on 2017/3/23.
//  Copyright © 2017年 陈睿. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!

    var isTyping: Bool = false
    
    var brain = CalculatorModel()
    
    var hasDot = false
    
    var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text=String(newValue)
        }
    }
    
    @IBAction func type(_ sender: UIButton) {
        let append = sender.currentTitle!
        if isTyping == false {
            if append != "0" {
                display.text = append
                isTyping = true
            }
        }else{
            display.text = display.text! + append
        }
    }
    
    @IBAction func putDot() {
        if !hasDot {
            hasDot = true
            display.text = display.text!+"."
        }
    }
    
    @IBAction func clear() {
        displayValue = 0
        brain.clear()
    }
    
    @IBAction func enter(_ sender: UIButton) {
        isTyping = false
        hasDot = false
        brain.pushNum(operand: displayValue)
        let result = brain.performOp(op: sender.currentTitle!)
        displayValue = result
    }
    
}

