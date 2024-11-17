//
//  CallToActionStatisticView.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 27.10.2024.
//

import UIKit

final class CallToActionStatisticView: UIView {
    
    let titleView = UILabel()
    let progressView = ProgressLineView()
    let titleNumberView = UILabel()
    
    private var percents: CGFloat = 0.0
    private var callToAction: CallsToAction = .none
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        setupTitleView()
        setupProgressView()
        setupTitleNumberView()
    }
    
    private func setupTitleView() {
        titleView.font = UIFont(name: "Courier New", size: 13)
        titleView.textColor = .lightGray
        titleView.numberOfLines = 1
        addSubview(titleView)
    }
    
    private func setupProgressView() {
        addSubview(progressView)
    }
    
    private func setupTitleNumberView() {
        titleNumberView.font = UIFont(name: "Courier New", size: 20)
        titleNumberView.textColor = .lightGray
        titleNumberView.numberOfLines = 1
        addSubview(titleNumberView)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutViews()
    }
    
    private func layoutViews() {
        layoutTitleView()
        layoutProgressView()
        layoutTitleNumberView()
    }
    
    private func layoutTitleView() {
        titleView.frame = CGRect(x: 0, y: 0, width: bounds.width * 0.3, height: bounds.height)
    }
    
    private func layoutProgressView() {
        progressView.layer.sublayers?.removeAll()
        progressView.frame = CGRect(x: titleView.frame.maxX + 10, y: 0, width: bounds.width * 0.5, height: bounds.height)
    }

    private func layoutTitleNumberView() {
        titleNumberView.frame = CGRect(x: bounds.width - bounds.width * 0.1, y: 0, width: bounds.width * 0.1, height: bounds.height)
    }
    
    // MARK: - Update
    
    func updateDatas(titleText: CallsToAction, percents: CGFloat, number: String, type: SymbolDataType) {
        titleView.text = titleText.rawValue
        self.percents = percents
        callToAction = titleText
        titleNumberView.text = number
        
        progressView.drawProgress(with: percents, callToAction: callToAction, type: type)
        
        
    }
    
}
