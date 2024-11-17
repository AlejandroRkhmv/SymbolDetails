//
//  MainFactory.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

enum SymbolDetailsHeadTitle: String {
    
    case technicals = "Technicals"
    case analyst = "Analyst rating"
    
    var title: String {
        switch self {
        case .technicals:
            return self.rawValue
        case .analyst:
            return self.rawValue
        }
    }
}

final class MainFactory {
    
    func makeSymbolDetails(from data: [SymbolDataDTO]?) -> [SymbolDetails] {
        guard let data = data else { return [] }
        let symbolDetails = data.map { details in
            
            let items = details.symbolDetailsData.map { item in
                return Item(type: item.title, title: item.title.rawValue, callToAction: findCallToAction(from: item.data), data: item.data)
            }
            
            return SymbolDetails(type: details.type, title: details.title.rawValue, items: items)
        }
        
        return symbolDetails
    }
    
    private func findCallToAction(from data: [CallsToAction: Int]) -> CallsToAction {
        let (key, _) = data.max(by: { $0.value < $1.value }) ?? (.none, 0)
        return key
    }
    
}

