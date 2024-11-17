//
//  BottomView.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 20.10.2024.
//

import UIKit

final class BottomView: UIView {
    
    private let type: SymbolDataType
    
    private let strongSellView = CallToActionStatisticView()
    private let sellView = CallToActionStatisticView()
    private let neutralView = CallToActionStatisticView()
    private let buyView = CallToActionStatisticView()
    private let strongBuyView = CallToActionStatisticView()
    
    private var views: [CallToActionStatisticView] = []
    
    // MARK: - Init
    
    init(type: SymbolDataType) {
        self.type = type
        super.init(frame: .zero)
        
        views = [strongSellView, sellView, neutralView, buyView, strongBuyView]
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        strongSellView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 5)
        sellView.frame = CGRect(x: 0, y: strongSellView.frame.maxY, width: bounds.width, height: bounds.height / 5)
        neutralView.frame = CGRect(x: 0, y: sellView.frame.maxY, width: bounds.width, height: bounds.height / 5)
        buyView.frame = CGRect(x: 0, y: neutralView.frame.maxY, width: bounds.width, height: bounds.height / 5)
        strongBuyView.frame = CGRect(x: 0, y: buyView.frame.maxY, width: bounds.width, height: bounds.height / 5)
        
        layoutIfNeeded()
    }
    
    // MARK: - Update
    
    func updateViews(with data: [CallsToAction: Int]) {
        views.enumerated().forEach { [weak self] index, view in
            guard let self else { return }
            view.updateDatas(
                titleText: CallsToAction.allCases[index],
                percents: makeActionPercents(from: data[CallsToAction.allCases[index]] ?? 0),
                number: String(data[CallsToAction.allCases[index]] ?? 0),
                type: type
            )
        }
    }
    
    private func makeActionPercents(from count: Int) -> CGFloat {
        return CGFloat(count) * 100 / 20
    }
    
}

// MARK: - CGFloat
extension CGFloat {
    
    fileprivate static let maxNumber = 20.0
    
}
