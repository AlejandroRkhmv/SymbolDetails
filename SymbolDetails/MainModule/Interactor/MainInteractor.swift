//
//  MainInteractor.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import Combine
import Foundation

protocol MainInteractorProtocol: AnyObject {
    
    var symbolDetailsDataPublisher: AnyPublisher<[SymbolDataDTO]?, Never> { get }
    
}

final class MainInteractor {
    
    private let service: any MainServiceProtocol
    private let dataGeneratorService: any DataGeneratorServiceProtocol
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(service: any MainServiceProtocol, dataGeneratorService: any DataGeneratorServiceProtocol) {
        self.service = service
        self.dataGeneratorService = dataGeneratorService
        
        subscribeOnData()
    }
    
    private func subscribeOnData() {
        let myThread = Thread { [weak self] in
            guard let self else { return }
            let runLoop = RunLoop.current
            Timer.publish(every: 5.0, on: runLoop, in: .common)
                .autoconnect()
                .sink  { [weak self] _ in
                    guard let self else { return }
                    let data = dataGeneratorService.makeData()
                    service.update(symbolDetailsData: data)
                }
                .store(in: &cancellable)
            runLoop.run()
        }
        myThread.start()
    }
}

// MARK: -
extension MainInteractor: MainInteractorProtocol {
    
    var symbolDetailsDataPublisher: AnyPublisher<[SymbolDataDTO]?, Never> {
        return service.symbolDetailsDataPublisher.eraseToAnyPublisher()
    }
    
}
