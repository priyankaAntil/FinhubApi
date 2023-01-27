//
//  CellVM.swift
//  Finnhub
//
//  Created by Priyanka on 21/01/23.
//

import Foundation
import FinnhubSwift
import Metal
import UIKit

class CellVM {
    
    var trades: Trade? {
        didSet {
            guard let data = trades else {
                return
            }
            self.symbol = data.s
            self.price = data.p
            self.value = data.p
        }
    }
    
    var symbol: String?
    
    private var price: Float?
    
    private var diffrence: Float = 0
    
    var diffrenceAndPercentage: String?
    
    private var previousValue: Float = 0
    
    var value: Float = 0.0 {
        didSet {
            self.diffrenceAndPercentage = self.getValue(prev: previousValue, current: value )
        }
        willSet {
            previousValue = value
        }
    }
    
    func getPrice() -> String {
        return String(format: "%.2f", price ?? 0)
    }
    lazy var valueColor: UIColor? = {
        return diffrence.sign == .minus ? .red : .green
    }()
    
    private func getValue(prev: Float, current: Float) -> String {
        diffrence = abs(((current - prev)*100).rounded()/100)
        let diffPercentage = abs((((diffrence * 100) / value) * 100).rounded()/100)
        return "(\(diffPercentage)%) \(diffrence)"
    }
    private func diffrencePercentage(diffrence: Float) -> String {
        
        let diff = (diffrence * 100) / value
        
        return "\((diff*100).rounded()/100) %"
    }
}
