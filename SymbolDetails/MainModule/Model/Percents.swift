//
//  Percents.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 27.10.2024.
//

import Foundation

enum Percents: CGFloat {
    
    case zero = 0
    case ten = 10
    case thirty = 30
    case fifty = 50
    case seventy = 70
    case ninety = 90
    
    init?(action: CallsToAction) {
        
        switch action {
        case .strongSell: self = Percents.ten
        case .sell: self = Percents.thirty
        case .neutral: self = Percents.fifty
        case .buy: self = Percents.seventy
        case .strongBuy: self = Percents.ninety
        case .none: self = Percents.zero
        }
        
    }
    
}
