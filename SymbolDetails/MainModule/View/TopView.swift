//
//  TopView.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 20.10.2024.
//

import UIKit

final class TopView: UIView {
    
    private let type: SymbolDataType
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let mainTitle = UILabel()
    
    private let strongSellTitle = UILabel()
    private let sellTitle = UILabel()
    private let neutralTitle = UILabel()
    private let buyTitle = UILabel()
    private let strongBuyTitle = UILabel()
    
    private let mainAction = UILabel()
    
    private let progressView = ProgressCurveView()
    private var persents: CGFloat = 0.0
    private var isPercentsIncreace: Bool {
        return Bool.random()
    }
    
    // MARK: - Init
    
    init(type: SymbolDataType) {
        self.type = type
        super.init(frame: .zero)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: size.height / 2)
    }
    
    // MARK: - Setup

    private func setupViews() {
        setupActivityIndicator()
        setupMainTitle()
        setupProgressView()
        setupMainAction()
        setupActionTitles()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.tintColor = .lightGray
        addSubview(activityIndicator)
    }
    
    private func setupMainTitle() {
        mainTitle.font = UIFont(name: "Courier New", size: 20)
        mainTitle.numberOfLines = 1
        mainTitle.textAlignment = .center
        mainTitle.textColor = .lightGray
        addSubview(mainTitle)
    }
    
    private func setupProgressView() {
        addSubview(progressView)
    }
    
    private func setupMainAction() {
        mainAction.font = UIFont(name: "Courier New", size: 18)
        mainAction.numberOfLines = 1
        mainAction.textAlignment = .center
        mainAction.text = ""
        addSubview(mainAction)
    }
    
    private func setupActionTitles() {
        strongSellTitle.font = UIFont(name: "Courier New", size: 10)
        strongSellTitle.textColor = .lightGray
        strongSellTitle.numberOfLines = 1
        strongSellTitle.textAlignment = .center
        strongSellTitle.text = CallsToAction.strongSell.rawValue
        strongSellTitle.isHidden = true
        addSubview(strongSellTitle)
        
        sellTitle.font = UIFont(name: "Courier New", size: 10)
        sellTitle.textColor = .lightGray
        sellTitle.numberOfLines = 1
        sellTitle.textAlignment = .center
        sellTitle.text = CallsToAction.sell.rawValue
        sellTitle.isHidden = true
        addSubview(sellTitle)
        
        neutralTitle.font = UIFont(name: "Courier New", size: 10)
        neutralTitle.textColor = .lightGray
        neutralTitle.numberOfLines = 1
        neutralTitle.textAlignment = .center
        neutralTitle.text = CallsToAction.neutral.rawValue
        neutralTitle.isHidden = true
        addSubview(neutralTitle)
        
        buyTitle.font = UIFont(name: "Courier New", size: 10)
        buyTitle.textColor = .lightGray
        buyTitle.numberOfLines = 1
        buyTitle.textAlignment = .center
        buyTitle.text = CallsToAction.buy.rawValue
        buyTitle.isHidden = true
        addSubview(buyTitle)
        
        strongBuyTitle.font = UIFont(name: "Courier New", size: 10)
        strongBuyTitle.textColor = .lightGray
        strongBuyTitle.numberOfLines = 1
        strongBuyTitle.textAlignment = .center
        strongBuyTitle.text = CallsToAction.strongBuy.rawValue
        strongBuyTitle.isHidden = true
        addSubview(strongBuyTitle)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutActivityIndicator()
        layoutMainTitle()
        layoutProgressView()
        layaoutMainAction()
        
        layoutStrongSellTitle()
        layoutSellTitle()
        layoutNeutralTitle()
        layoutBuyTitle()
        layoutStrongBuyTitle()
        
        layoutIfNeeded()
    }
    
    private func layoutActivityIndicator() {
        let size = activityIndicator.frame.size
        let origin = if traitCollection.verticalSizeClass == .regular, traitCollection.horizontalSizeClass == .compact {
            CGPoint(x: bounds.midX - size.width / 2.0, y: bounds.maxY - size.height / 2.0)
        } else {
            CGPoint(x: bounds.maxX - size.width / 2.0, y: bounds.midY - size.height / 2.0)
        }
        activityIndicator.frame = CGRect(origin: origin, size: size)
    }
    
    private func layoutMainTitle() {
        mainTitle.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 20)
    }
    
    private func layoutProgressView() {
        progressView.layer.sublayers?.removeAll()
        
        progressView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width - UIEdgeInsets.insets.left - UIEdgeInsets.insets.right,
            height: bounds.height - UIEdgeInsets.insets.top - UIEdgeInsets.insets.bottom)
        
        progressView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        progressView.makeCirclePaths(with: progressView.bounds)
    }
    
    
    private func layaoutMainAction() {
        mainAction.frame = CGRect(
            x: bounds.midX - max(mainAction.sizeThatFits(bounds.size).width, progressView.frame.width) / 2.0,
            y: progressView.frame.maxY - max(mainAction.sizeThatFits(bounds.size).height, 22),
            width: max(mainAction.sizeThatFits(bounds.size).width, progressView.frame.width),
            height: max(mainAction.sizeThatFits(bounds.size).height, 22)
        )
    }
    
    private func layoutStrongSellTitle() {
        let strongSellTitleSize = strongSellTitle.sizeThatFits(bounds.size)
        let originX = progressView.frame.midX - progressView.radius - strongSellTitleSize.width - .padding
        let originY = progressView.centerOfCircle.y - progressView.radius / 3
        let origin = CGPoint(x: originX, y: originY)
        strongSellTitle.frame = CGRect(origin: origin, size: strongSellTitleSize)
    }
    
    private func layoutStrongBuyTitle() {
        let strongBuyTitleSize = strongBuyTitle.sizeThatFits(bounds.size)
        let originX = progressView.frame.midX + progressView.radius + .padding
        let originY = progressView.centerOfCircle.y - progressView.radius / 3
        let origin = CGPoint(x: originX, y: originY)
        strongBuyTitle.frame = CGRect(origin: origin, size: strongBuyTitleSize)
    }
    
    private func layoutSellTitle() {
        let sellTitleSize = sellTitle.sizeThatFits(bounds.size)
        let originX = bounds.midX / 2 - sellTitleSize.width / 2.0
        let originY = progressView.centerOfCircle.y - (sin(60.0 / .countOfDegreesInOneRadian) * progressView.radius)
        let origin = CGPoint(x: originX, y: originY)
        sellTitle.frame = CGRect(origin: origin, size: sellTitleSize)
    }
    
    private func layoutBuyTitle() {
        let buyTitleSize = buyTitle.sizeThatFits(bounds.size)
        let originX = bounds.midX + bounds.midX / 2 - buyTitleSize.width / 2.0
        let originY = progressView.centerOfCircle.y - (sin(60.0 / .countOfDegreesInOneRadian) * progressView.radius)
        let origin = CGPoint(x: originX, y: originY)
        buyTitle.frame = CGRect(origin: origin, size: buyTitleSize)
    }
    
    private func layoutNeutralTitle() {
        let neutralTitleSize = neutralTitle.sizeThatFits(bounds.size)
        let originX = bounds.midX - neutralTitleSize.width / 2.0
        let originY = progressView.centerOfCircle.y - progressView.radius - .padding - neutralTitleSize.height
        let origin = CGPoint(x: originX, y: originY)
        neutralTitle.frame = CGRect(origin: origin, size: neutralTitleSize)
    }
    
    // MARK: - Update
    
    func updateProgress(with action: CallsToAction, title: String) {
        update(title: title)
        updateCallToActionTitleColor(action: action)
        updateMainAction(action: action)
        persents = Percents(action: action)?.rawValue ?? 50.0
        progressView.drawProgress(with: persents, type: type)
        updateVisibility()
    }
    
    func updatePercentsForAnimation() {
        updatePercents()
        
        //setNeedsLayout()
    }
    
    // MARK: - Private Updates
    
    private func updateVisibility() {
        strongSellTitle.isHidden = false
        sellTitle.isHidden = false
        neutralTitle.isHidden = false
        buyTitle.isHidden = false
        strongBuyTitle.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    private func update(title: String) {
        mainTitle.text = title
    }
    
    private func updateMainAction(action: CallsToAction) {
        var colors: [UIColor] = []
        
        switch type {
        case .technicals:
            colors = [
                UIColor(hex: "#FF5733") ?? UIColor.clear,
                UIColor(hex: "#FF7D33") ?? UIColor.clear,
                UIColor(hex: "#FF9933") ?? UIColor.clear,
                UIColor(hex: "#FFB733") ?? UIColor.clear,
                UIColor(hex: "#FFD733") ?? UIColor.clear
            ]
        case .analyst:
            colors = [
                UIColor(hex: "#33FF57") ?? UIColor.clear,
                UIColor(hex: "#8DFF33") ?? UIColor.clear,
                UIColor(hex: "#D1FF33") ?? UIColor.clear,
                UIColor(hex: "#D1C133") ?? UIColor.clear,
                UIColor(hex: "#C7A539") ?? UIColor.clear
            ]
        }
        
        mainAction.text = action.rawValue
        guard let number = action.number else { return }
        mainAction.textColor = colors[number]
    }
    
    private func updateCallToActionTitleColor(action: CallsToAction) {
        
        var colors: [UIColor] = []
        
        switch type {
        case .technicals:
            colors = [
                UIColor(hex: "#FF5733") ?? UIColor.clear,
                UIColor(hex: "#FF7D33") ?? UIColor.clear,
                UIColor(hex: "#FF9933") ?? UIColor.clear,
                UIColor(hex: "#FFB733") ?? UIColor.clear,
                UIColor(hex: "#FFD733") ?? UIColor.clear
            ]
        case .analyst:
            colors = [
                UIColor(hex: "#33FF57") ?? UIColor.clear,
                UIColor(hex: "#8DFF33") ?? UIColor.clear,
                UIColor(hex: "#D1FF33") ?? UIColor.clear,
                UIColor(hex: "#D1C133") ?? UIColor.clear,
                UIColor(hex: "#C7A539") ?? UIColor.clear
            ]
        }
        
        
        
        switch action {
        case .strongSell:
            guard let number = action.number else { return }
            strongSellTitle.textColor = colors[number]
            sellTitle.textColor = .lightGray
            neutralTitle.textColor = .lightGray
            buyTitle.textColor = .lightGray
            strongBuyTitle.textColor = .lightGray
        case .sell:
            guard let number = action.number else { return }
            strongSellTitle.textColor = .lightGray
            sellTitle.textColor = colors[number]
            neutralTitle.textColor = .lightGray
            buyTitle.textColor = .lightGray
            strongBuyTitle.textColor = .lightGray
        case .neutral:
            guard let number = action.number else { return }
            strongSellTitle.textColor = .lightGray
            sellTitle.textColor = .lightGray
            neutralTitle.textColor = colors[number]
            buyTitle.textColor = .lightGray
            strongBuyTitle.textColor = .lightGray
        case .buy:
            guard let number = action.number else { return }
            strongSellTitle.textColor = .lightGray
            sellTitle.textColor = .lightGray
            neutralTitle.textColor = .lightGray
            buyTitle.textColor = colors[number]
            strongBuyTitle.textColor = .lightGray
        case .strongBuy:
            guard let number = action.number else { return }
            strongSellTitle.textColor = .lightGray
            sellTitle.textColor = .lightGray
            neutralTitle.textColor = .lightGray
            buyTitle.textColor = .lightGray
            strongBuyTitle.textColor = colors[number]
        case .none:
            return
        }
    }
    
    private func updatePercents() {
        let date = Date()
        let calendar = Calendar.current
        let currentSecond = calendar.component(.second, from: date)
        
        if currentSecond % 2 == 0 {
            persents += isPercentsIncreace ? 0.3 : -0.3
        } else {
            persents += isPercentsIncreace ? -0.3 : 0.3
        }
    }
    
}

// MARK: - CGFloat
extension UIEdgeInsets {
    
    fileprivate static let insets = UIEdgeInsets(top: 15.0, left: 65.0, bottom: 15.0, right: 65.0)
    
}

// MARK: - CGFloat
extension CGFloat {
    
    fileprivate static let countOfDegreesInOneRadian = 57.3
    fileprivate static let padding = 10.0
    
}
