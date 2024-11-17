//
//  MainViewModel.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import Combine
import Foundation

protocol MainViewModelProtocol: AnyObject {
    
}

final class MainViewModel: MainViewModelProtocol {
    
    weak var view: (any MainViewControllerInput)?
    private let interactor: any MainInteractorProtocol
    private let factory: MainFactory
    
    private var timer = Timer()
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(interactor: any MainInteractorProtocol, factory: MainFactory) {
        self.interactor = interactor
        self.factory = factory
        makeDateTimer()
        subscribeOnData()
    }
    
    deinit {
        timer.invalidate()
    }
    
    private func subscribeOnData() {
        interactor.symbolDetailsDataPublisher
            .dropFirst()
            .sink { [weak self] data in
                guard let self else { return }
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    let uiModels = factory.makeSymbolDetails(from: data)
                    view?.updateView(with: uiModels)
                }
            }
            .store(in: &cancellable)
    }
    
    private func makeDateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
    }
    
    @objc private func updateDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.string(from: Date())
        view?.update(date: date)
    }
    
}
