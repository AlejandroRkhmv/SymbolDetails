//
//  ProgressLineView.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 27.10.2024.
//

import UIKit

final class ProgressLineView: UIView {
    
    private var currentPercents: CGFloat = 0.0
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawProgress(with percents: CGFloat, callToAction: CallsToAction, type: SymbolDataType) {
        layer.sublayers?.removeAll()
        
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
        
        
        let  backgroundPath = UIBezierPath()
        backgroundPath.move(to: CGPoint(x: 0, y: bounds.size.height / 2))
        backgroundPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height / 2))
        
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 15.0
        backgroundLayer.strokeEnd = 1
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineCap = .round
        
        
        
        let  percentsPath = UIBezierPath()
        percentsPath.move(to: CGPoint(x: 0, y: bounds.size.height / 2))
        percentsPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height / 2))
        
        //animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = CACurrentMediaTime() + 0.1
        animation.duration = 2
        animation.fromValue = currentPercents / 100
        animation.toValue = percents / 100
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        let percentsLayer = CAShapeLayer()
        percentsLayer.path = percentsPath.cgPath
        guard let number = callToAction.number else { return }
        percentsLayer.strokeColor = colors[number].cgColor
        percentsLayer.lineWidth = 15.0
        percentsLayer.strokeEnd = percents / 100
        percentsLayer.fillColor = UIColor.clear.cgColor
        percentsLayer.lineCap = .round
        
        percentsLayer.removeAnimation(forKey: "lineAnimation")
        percentsLayer.strokeEnd = currentPercents / 100
        percentsLayer.add(animation, forKey: "lineAnimation")
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(percentsLayer)
        currentPercents = percents
    }
    
}
