//
//  SymbolDetails.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

struct SymbolDetails: Hashable {
    
    let type: GroupType
    let title: String
    let items: [Item]
    
}

struct Item: Hashable {
    
    let type: SymbolDetailsTitle
    let title: String
    let callToAction: CallsToAction
    let data: [CallsToAction: Int]
    
}
