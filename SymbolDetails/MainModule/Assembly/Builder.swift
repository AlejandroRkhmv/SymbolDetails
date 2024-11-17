//
//  Builder.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import UIKit

final class Builder {
    
    static func makeMainModule() -> UIViewController {
        let store = MainStore()
        let service = MainService(store: store)
        let dataGeneratorService = DataGeneratorService()
        let interactor = MainInteractor(service: service, dataGeneratorService: dataGeneratorService)
        let factory = MainFactory()
        let viewModel = MainViewModel(interactor: interactor, factory: factory)
        let viewController = MainViewController()
        viewModel.view = viewController
        return viewController
    }
    
}
