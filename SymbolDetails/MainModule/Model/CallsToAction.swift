//
//  CallsToAction.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

enum CallsToAction: String, CaseIterable {
    
    case strongSell = "Strong Sell"
    case sell = "Sell"
    case neutral = "Neutral"
    case buy = "Buy"
    case strongBuy = "Strong Buy"
    case none = ""
    
    static var allCases: [CallsToAction] = [.strongSell, .sell, .neutral, .buy, .strongBuy]
    
    var number: Int? {
        
        switch self {
        case .strongSell: return 0
        case .sell: return 1
        case .neutral: return 2
        case .buy: return 3
        case .strongBuy: return 3
        case .none: return nil
        }
        
    }
    
}
