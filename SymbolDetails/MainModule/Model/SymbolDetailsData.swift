//
//  SymbolDetailsData.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

enum GroupType {
    
    case technicals
    case analyst
    
}

struct SymbolDataDTO: Hashable {
    
    let type: GroupType
    let title: SymbolDetailsHeadTitle
    let symbolDetailsData: [SymbolDetailsData]
    
}

struct SymbolDetailsData: Hashable {
    
    let title: SymbolDetailsTitle
    let data: [CallsToAction: Int]
    
}
