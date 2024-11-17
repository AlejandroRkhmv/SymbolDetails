//
//  ViewController.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let symbolDetailsButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        makeButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = symbolDetailsButton.sizeThatFits(view.bounds.size)
        symbolDetailsButton.frame = CGRect(
            origin: CGPoint(
                x: (view.bounds.size.width - size.width) / 2.0,
                y: (view.bounds.size.height - size.height) / 2.0
            ),
            size: size
        )
    }
    
    private func setupButton() {
        view.addSubview(symbolDetailsButton)
        let action = UIAction { _ in
            // These are to router
            guard let navigationController = self.navigationController else { return }
            let mainViewController = Builder.makeMainModule()
            navigationController.pushViewController(mainViewController, animated: false)
        }
        symbolDetailsButton.addAction(action, for: .touchUpInside)
    }

    private func makeButton() {
        var attributedTitle = AttributedString("Symbol Details")
        attributedTitle.foregroundColor = .systemPurple
        
        symbolDetailsButton.configuration = .plain()
        symbolDetailsButton.configuration?.attributedTitle = attributedTitle
        symbolDetailsButton.configurationUpdateHandler = { button in
            if button.isHighlighted {
                button.alpha = 0.5
            } else {
                button.alpha = 1.0
            }
        }
    }
}

