//
//  ProgressCurveView.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 20.10.2024.
//

import UIKit

final class ProgressCurveView: UIView {
    
    private var circlePath = UIBezierPath()
    private var circleBackgroundPath = UIBezierPath()
    
    private var currentPercents: CGFloat = 0.0
    
    var radius: CGFloat = 0.0
    var centerOfCircle: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCirclePaths(with bounds: CGRect) {
        let circleFrame = bounds.inset(by: .insets)
        let originY = if traitCollection.verticalSizeClass == .regular, traitCollection.horizontalSizeClass == .compact {
            bounds.height
        } else {
            bounds.height * 4 / 5
        }
        let center = CGPoint(x: bounds.midX, y: originY)
        self.centerOfCircle = center
        let radius = circleFrame.width / 2.0
        self.radius = radius
        let startAngle = -CGFloat.pi
        let endAngle = 0.0
        circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circleBackgroundPath = UIBezierPath(arcCenter: center, radius: radius - 12.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }
    
    func drawProgress(with percents: CGFloat, type: SymbolDataType) {
        
        layer.sublayers?.removeAll()
        
        //gray
        let backgroundCircleLayer = makeBackgroundCircleLayer()
        layer.addSublayer(backgroundCircleLayer)
        
        //main progress
        let gradientLayer = makeGradientLayer(type: type)
        layer.addSublayer(gradientLayer)
        
        let circleLayer = makeProgressLayer(percents: percents)
        gradientLayer.mask = circleLayer
        
        // background progress
        let backgroundGradientLayer = makeBackgroundGradientLayer(type: type)
        layer.addSublayer(backgroundGradientLayer)
        
        let backgroundProgressLayer = makeBackgroundProgressLayer(percents: percents)
        backgroundGradientLayer.mask = backgroundProgressLayer
        
        
        currentPercents = percents
    }
    
    private func makeBackgroundCircleLayer() -> CAShapeLayer {
        let backgroundCircleLayer = CAShapeLayer()
        backgroundCircleLayer.path = circlePath.cgPath
        backgroundCircleLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundCircleLayer.lineWidth = 15.0
        backgroundCircleLayer.strokeEnd = 1
        backgroundCircleLayer.fillColor = UIColor.clear.cgColor
        return backgroundCircleLayer
    }
    
    private func makeGradientLayer(type: SymbolDataType) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        
        switch type {
        case .technicals:
            gradientLayer.colors = [
                UIColor(hex: "#FF5733")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FF7D33")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FF9933")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FFB733")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FFD733")?.cgColor ?? UIColor.clear.cgColor
            ]
        case .analyst:
            gradientLayer.colors = [
                UIColor(hex: "#33FF57")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#8DFF33")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#D1FF33")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#D1C133")?.cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#C7A539")?.cgColor ?? UIColor.clear.cgColor
            ]
        }
        
        gradientLayer.locations = [0.0, 0.25, 0.5, 0.75, 1.0]
        
        return gradientLayer
    }
    
    private func makeProgressLayer(percents: CGFloat) -> CAShapeLayer {
        
        //animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = CACurrentMediaTime() + 0.1
        animation.duration = 2
        animation.fromValue = currentPercents / 100
        animation.toValue = percents / 100
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 15.0
        circleLayer.strokeEnd = percents / 100
        circleLayer.fillColor = UIColor.clear.cgColor
        
        circleLayer.removeAnimation(forKey: "circleAnimation")
        circleLayer.strokeEnd = currentPercents / 100
        circleLayer.add(animation, forKey: "circleAnimation")
        
        return circleLayer
    }
    
    private func makeBackgroundGradientLayer(type: SymbolDataType) -> CAGradientLayer {
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = bounds
        backgroundGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        backgroundGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        switch type {
        case .technicals:
            backgroundGradientLayer.colors = [
                UIColor(hex: "#FF5733")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FF7D33")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FF9933")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FFB733")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#FFD733")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor
            ]
        case .analyst:
            backgroundGradientLayer.colors = [
                UIColor(hex: "#33FF57")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#8DFF33")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#D1FF33")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#D1C133")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor,
                UIColor(hex: "#C7A539")?.withAlphaComponent(0.3).cgColor ?? UIColor.clear.cgColor
            ]
        }
        
        backgroundGradientLayer.locations = [0.0, 0.25, 0.5, 0.75, 1.0]
        return backgroundGradientLayer
    }
    
    private func makeBackgroundProgressLayer(percents: CGFloat) -> CAShapeLayer {
        
        //animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = CACurrentMediaTime() + 0.1
        animation.duration = 2
        animation.fromValue = currentPercents / 100
        animation.toValue = percents / 100
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circleBackgroundPath.cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 12.0
        circleLayer.strokeEnd = percents / 100
        circleLayer.fillColor = UIColor.clear.cgColor
        
        circleLayer.removeAnimation(forKey: "circleAnimation")
        circleLayer.strokeEnd = currentPercents / 100
        circleLayer.add(animation, forKey: "circleAnimation")
        
        return circleLayer
    }
    
}

// MARK: - CGFloat
extension UIEdgeInsets {
    
    fileprivate static let insets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
    
}

// MARK: -
extension UIColor {
    convenience init?(hex: String) {
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexColor = hexColor.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexColor).scanHexInt64(&rgb) else {
            return nil
        }
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
