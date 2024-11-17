//
//  MainService.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import Combine

protocol MainServiceProtocol: AnyObject {
    
    var symbolDetailsDataPublisher: AnyPublisher<[SymbolDataDTO]?, Never> { get }
    
    func update(symbolDetailsData: [SymbolDataDTO])
    
}

final class MainService {
    
    private let store: any MainStoreProtocol
    
    init(store: any MainStoreProtocol) {
        self.store = store
    }
    
}

// MARK: -
extension MainService: MainServiceProtocol {
    
    var symbolDetailsDataPublisher: AnyPublisher<[SymbolDataDTO]?, Never> {
        return store.symbolDetailsDataPublisher.eraseToAnyPublisher()
    }
    
    func update(symbolDetailsData: [SymbolDataDTO]) {
        store.update(symbolDetailsData: symbolDetailsData)
    }
    
}
