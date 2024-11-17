//
//  MainViewController.swift
//  SymbolDetails
//
//  Created by Александр Рахимов on 19.10.2024.
//

import UIKit

protocol MainViewControllerInput: AnyObject {
    
    func updateView(with models: [SymbolDetails])
    func update(date: String)
    
}

final class MainViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    
    private let technicalsHeadTitle = UILabel()
    private let analystHeadTitle = UILabel()
    
    private let oscillatorsDetailsView = SymbolDataView(type: .technicals)
    private let movingAveragesDetailsView = SymbolDataView(type: .technicals)
    private let summaryDetailsView = SymbolDataView(type: .technicals)
    private let analystRatingDetailsView = SymbolDataView(type: .analyst)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .lightGray
        setupNavigationTitle()
        setupScrollView()
        setupDetailsViews()
        setupTitles()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutScrollView()
        layoutViews()
    }
    
    // MARK: - Setup
    
    private func setupNavigationTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.string(from: Date())
        navigationItem.title = date + " UTC"
    }
    
    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func setupDetailsViews() {
        scrollView.addSubview(oscillatorsDetailsView)
        scrollView.addSubview(movingAveragesDetailsView)
        scrollView.addSubview(summaryDetailsView)
        scrollView.addSubview(analystRatingDetailsView)
    }
    
    private func setupTitles() {
        technicalsHeadTitle.text = SymbolDetailsHeadTitle.technicals.rawValue
        technicalsHeadTitle.font = UIFont(name: "Courier New", size: 24.0)
        technicalsHeadTitle.textColor = .lightGray
        scrollView.addSubview(technicalsHeadTitle)
        
        analystHeadTitle.text = SymbolDetailsHeadTitle.analyst.rawValue
        analystHeadTitle.font = UIFont(name: "Courier New", size: 24.0)
        analystHeadTitle.textColor = .lightGray
        scrollView.addSubview(analystHeadTitle)
    }
    
    // MARK: - Layout
    
    private func layoutScrollView() {
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func layoutViews() {
        var contentHeight: CGFloat = 0
        
        let technicalsHeadTitleHeight = layout(title: technicalsHeadTitle, contentHeight: contentHeight)
        contentHeight += technicalsHeadTitleHeight + .spacing
        
        let oscillatorsDetailsViewHeight = layout(detailView: oscillatorsDetailsView, contentHeight: contentHeight)
        contentHeight += oscillatorsDetailsViewHeight + .spacing
        
        let movingAveragesDetailsViewHeight = layout(detailView: movingAveragesDetailsView, contentHeight: contentHeight)
        contentHeight += movingAveragesDetailsViewHeight + .spacing
        
        let summaryDetailsViewHeight = layout(detailView: summaryDetailsView, contentHeight: contentHeight)
        contentHeight += summaryDetailsViewHeight + .spacing * 2.0
        
        let analystHeadTitleHeight = layout(title: analystHeadTitle, contentHeight: contentHeight)
        contentHeight += analystHeadTitleHeight + .spacing
        
        let analystRatingDetailsViewHeight = layout(detailView: analystRatingDetailsView, contentHeight: contentHeight)
        contentHeight += analystRatingDetailsViewHeight + .spacing
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
    private func layout(detailView: SymbolDataView, contentHeight: CGFloat) -> CGFloat {
        let detailViewHeight: CGFloat = detailView.sizeThatFits(view.bounds.size).height
        let origin = CGPoint(
            x: max(view.safeAreaInsets.left, (.horizontalInset / 2.0)),
            y: contentHeight
        )
        let size = CGSize(
            width: min(view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right, view.bounds.width - .horizontalInset),
            height: detailViewHeight
        )
        
        detailView.frame = CGRect(origin: origin, size: size)
        return detailViewHeight
    }
    
    private func layout(title: UILabel, contentHeight: CGFloat) -> CGFloat {
        let titleSize = title.sizeThatFits(view.bounds.size)
        let origin = CGPoint(
            x: view.bounds.midX - titleSize.width / 2.0,
            y: contentHeight
        )
        
        title.frame = CGRect(origin: origin, size: titleSize)
        return titleSize.height
        
    }
    
}

// MARK: - MainViewControllerInput
extension MainViewController: MainViewControllerInput {
    
    func updateView(with models: [SymbolDetails]) {
        models.forEach { [weak self] model in
            guard let self else { return }
            switch model.type {
            case .technicals:
                
                model.items.forEach { [weak self] item in
                    guard let self else { return }
                    switch item.type {
                    case .oscillators:
                        oscillatorsDetailsView.updateTopView(with: item.callToAction, title: item.type.rawValue)
                        oscillatorsDetailsView.updateBottomView(with: item.data)
                    case .movingAverages:
                        movingAveragesDetailsView.updateTopView(with: item.callToAction, title: item.type.rawValue)
                        movingAveragesDetailsView.updateBottomView(with: item.data)
                    case .summary:
                        summaryDetailsView.updateTopView(with: item.callToAction, title: item.type.rawValue)
                        summaryDetailsView.updateBottomView(with: item.data)
                    case .analystRating:
                        break
                    }
                }
            case .analyst:
                
                model.items.forEach { [weak self] item in
                    guard let self else { return }
                    switch item.type {
                    case .oscillators, .movingAverages, .summary:
                        break
                    case .analystRating:
                        analystRatingDetailsView.updateTopView(with: item.callToAction, title: item.type.rawValue)
                        analystRatingDetailsView.updateBottomView(with: item.data)
                    }
                }
            }
        }
    }
    
    func update(date: String) {
        navigationItem.title = date + " UTC"
        oscillatorsDetailsView.animateProgress()
        movingAveragesDetailsView.animateProgress()
        summaryDetailsView.animateProgress()
        analystRatingDetailsView.animateProgress()
    }
    
}

// MARK: - CGFloat
extension CGFloat {
    
    fileprivate static let horizontalInset = 30.0
    fileprivate static let spacing = 20.0
    
}
