//
//  DataGeneratorService.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

protocol DataGeneratorServiceProtocol: AnyObject {
    
    func makeData() -> [SymbolDataDTO]
    
}

final class DataGeneratorService: DataGeneratorServiceProtocol {
    
    func makeData() -> [SymbolDataDTO] {
        let technicals = makeTechnicals()
        let analytics = makeAnalystRating()
        return [SymbolDataDTO(type: .technicals, title: .technicals, symbolDetailsData: technicals),
                SymbolDataDTO(type: .analyst, title: .analyst, symbolDetailsData: [analytics])]
    }
    
    private func makeOscillators() -> SymbolDetailsData {
        return SymbolDetailsData(
            title: .oscillators,
            data: [
                .strongSell: generateNumber(),
                .sell: generateNumber(),
                .neutral: generateNumber(),
                .buy: generateNumber(),
                .strongBuy: generateNumber()
            ]
        )
    }
    
    private func makeMovingAverages() -> SymbolDetailsData {
        return SymbolDetailsData(
            title: .movingAverages,
            data: [
                .strongSell: generateNumber(),
                .sell: generateNumber(),
                .neutral: generateNumber(),
                .buy: generateNumber(),
                .strongBuy: generateNumber()
            ]
        )
    }
    
    private func makeTechnicals() -> [SymbolDetailsData] {
        let oscillators = makeOscillators()
        let movingAverages = makeMovingAverages()
        let summary = SymbolDetailsData(
            title: .summary,
            data: [
                .strongSell: ((oscillators.data[.strongSell] ?? 0) + (movingAverages.data[.strongSell] ?? 0)) / 2,
                .sell: ((oscillators.data[.sell] ?? 0) + (movingAverages.data[.sell] ?? 0)) / 2,
                .neutral: ((oscillators.data[.neutral] ?? 0) + (movingAverages.data[.neutral] ?? 0)) / 2,
                .buy: ((oscillators.data[.buy] ?? 0) + (movingAverages.data[.buy] ?? 0)) / 2,
                .strongBuy: ((oscillators.data[.strongBuy] ?? 0) + (movingAverages.data[.strongBuy] ?? 0)) / 2
            ]
        )
        return [makeOscillators(), makeMovingAverages(), summary]
    }
    
    private func makeAnalystRating() -> SymbolDetailsData {
        return SymbolDetailsData(
            title: .analystRating,
            data: [
                .strongSell: generateNumber(),
                .sell: generateNumber(),
                .neutral: generateNumber(),
                .buy: generateNumber(),
                .strongBuy: generateNumber()
            ]
        )
    }
    
    private func generateNumber() -> Int {
        return Int.random(in: 0...20)
    }
    
}
