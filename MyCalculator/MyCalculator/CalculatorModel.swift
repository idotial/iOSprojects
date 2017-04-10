//
//  CalculatorModel.swift
//  MyCalculator
//
//  Created by 陈睿 on 2017/4/2.
//  Copyright © 2017年 陈睿. All rights reserved.
//

import Foundation

class CalculatorModel {
    enum mathOperator {
        case unaryOp((Double)->Double)
        case binaryOp((Double,Double)->Double)
    }
    var opStack=[mathOperator]()
    
    var numStack=[Double]()
    
    private var knowOps = Dictionary<String,mathOperator>()
    init() {
        knowOps["✖️"] = mathOperator.binaryOp(*)
        knowOps["➗"] = mathOperator.binaryOp({ $1 / $0 })
        knowOps["➕"] = mathOperator.binaryOp(+)
        knowOps["➖"] = mathOperator.binaryOp({ $1 - $0 })
        knowOps["✔️"] = mathOperator.unaryOp(sqrt)
        knowOps["="] = mathOperator.unaryOp({$0})
        knowOps["+／-"] = mathOperator.unaryOp({-$0})
    }
    
    func evaluate() ->Double {
        var result = 0.0
        if opStack.isEmpty {
            if let currentnum = numStack.last {
                result =  currentnum
            }
        }else if !numStack.isEmpty{
            switch opStack.removeLast(){
            case .binaryOp(let operationMath):
                if numStack.count>=2 {
                    result = operationMath(numStack.removeLast(),numStack.removeLast())
                }
            case .unaryOp(let operationMath):
                    result = operationMath(numStack.removeLast())
            }
        }
        opStack.removeAll()
        numStack.removeAll()
        numStack.append(result)
        return result
    }
    
    func pushNum(operand:Double) {
        numStack.append(operand)
    }
    
    func performOp(op:String) -> Double {
        var result:Double
        switch knowOps[op]! {
        case .binaryOp(_):
            result = evaluate()
            opStack.append(knowOps[op]!)
        case .unaryOp(_):
            evaluate()
            opStack.append(knowOps[op]!)
            result = evaluate()
        }
    return result
    }
    
    func clear(){
        numStack.removeAll()
        opStack.removeAll()
    }
}
