//
//  SymbolDataView.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import UIKit

enum SymbolDataType {
    
    case technicals
    case analyst
    
}

final class SymbolDataView: UIView {
    
    private let type: SymbolDataType
    private var topView: TopView
    private var bottomView: BottomView
    
    
    // MARK: - Init
    
    init(type: SymbolDataType) {
        self.type = type
        topView = TopView(type: type)
        bottomView = BottomView(type: type)
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(topView)
        addSubview(bottomView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    private func layoutViews() {
        if traitCollection.verticalSizeClass == .regular, traitCollection.horizontalSizeClass == .compact {
            topView.frame = CGRect(x: .zero, y: .zero, width: bounds.width, height: bounds.height / 2.0)
            bottomView.frame = CGRect(x: .zero, y: topView.frame.maxY, width: bounds.width, height: bounds.height / 2.0)
        } else {
            topView.frame = CGRect(x: .zero, y: .zero, width: bounds.width / 2.0, height: bounds.height * 0.75)
            bottomView.frame = CGRect(x: topView.frame.maxX + 10, y: .zero, width: bounds.width / 2.0, height: bounds.height * 0.75)
        }
    }
    
    // MARK: - Sizing
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if traitCollection.verticalSizeClass == .regular, traitCollection.horizontalSizeClass == .compact {
            return CGSize(width: size.width, height: size.width)
        } else {
            return CGSize(width: size.width, height: size.height)
        }
    }
    
    // MARK: - Update
    
    func updateTopView(with action: CallsToAction, title: String) {
        topView.updateProgress(with: action, title: title)
    }
    
    func animateProgress() {
        topView.updatePercentsForAnimation()
    }
    
    func updateBottomView(with data: [CallsToAction: Int]) {
        bottomView.updateViews(with: data)
    }
    
}
