//
//  MainStore.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import Combine

protocol MainStoreProtocol: AnyObject {
    
    var symbolDetailsDataPublisher: AnyPublisher<[SymbolDataDTO]?, Never> { get }
    
    func update(symbolDetailsData: [SymbolDataDTO])
    
}

final class MainStore {
    
    private let symbolDetailsDataCurrentValueSubject = CurrentValueSubject<[SymbolDataDTO]?, Never>(nil)
    
}

// MARK: -
extension MainStore: MainStoreProtocol {
    
    var symbolDetailsDataPublisher: AnyPublisher<[SymbolDataDTO]?, Never> {
        return symbolDetailsDataCurrentValueSubject.eraseToAnyPublisher()
    }
    
    func update(symbolDetailsData: [SymbolDataDTO]) {
        symbolDetailsDataCurrentValueSubject.send(symbolDetailsData)
    }
    
}
