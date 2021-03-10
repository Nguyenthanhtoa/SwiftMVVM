//
//  SegmentedView.swift
//  iOS
//
//  Created by ThanhToa on 2/22/19.
//  Copyright © 2019 ToaNT1. All rights reserved.
//
import DDMvvm
import RxCocoa
import RxSwift
import Foundation

extension Reactive where Base: SegmentedView {
    
    var selectedIndex: ControlProperty<Int> {
        return UIControl.toProperty(control: self.base, getter: { (segmentedView) in
            segmentedView.selectedIndex
        }, setter: {(segmentedView, value) in
            if (value != segmentedView.selectedIndex) {
                segmentedView.selectedIndex = value
            }
        })
    }
    
    var titles: ControlProperty<[String]?> {
        return UIControl.toProperty(control: self.base, getter: { (segmentedView) in
            segmentedView.titles
        }, setter: {(segmentedView, value) in
            segmentedView.titles = value ?? []
        })
    }
    
}

class SegmentedView: AbstractControlView {
    
    var titles: [String] {
        didSet {
            if oldValue != titles {
                setupView()
            }
        }
    }
    
    var apportionsSegmentWidthsByContent: Bool {
        didSet { updateDistribution() }
    }
    
    var boxColor: UIColor = .white
    var indicatorColor: UIColor = .clear
    var hasShadow = false
    var isRolled = false
    
    private var scrollView: UIScrollView!
    private var shadowView: UIView!
    private var stackView: UIStackView!
    private var indicatorView: UIView!
    
    private var verticalConstraint: NSLayoutConstraint!
    
    var selectedIndex = 0 {
        didSet {
            if selectedIndex < buttons.count {
                buttons.forEach { $0.isSelected = false }
                let selectedBtn = buttons[selectedIndex]
                selectedBtn.isSelected = true
                moveIndicator(relativeTo: selectedBtn)
            }
            
            sendActions(for: .valueChanged)
        }
    }
    
    private var buttons: [UIButton] = []
    
    private let indicatorWidth: CGFloat = 30
    
    var leadingConst: NSLayoutConstraint!
    
    init(withTitles titles: [String] = [], apportionsSegmentWidthsByContent: Bool = true) {
        self.titles = titles
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.titles = []
        self.apportionsSegmentWidthsByContent = true
        super.init(coder: aDecoder)
    }
    
    override func setupView() {
        if titles.count == 0 {
            return
        }
        
        autoSetDimension(.height, toSize: 50)
        
        shadowView = UIView()
        shadowView.backgroundColor = .clear
        addSubview(shadowView)
        shadowView.autoPinEdgesToSuperviewEdges()
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        shadowView.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
        
        stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .fill
        updateDistribution()
        scrollView.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        stackView.autoSetDimension(.height, toSize: 50)
        
        for title in titles {
            let btn = UIButton(type: .custom)
            buttons.append(btn)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(.white, for: .highlighted)
            btn.setTitleColor(.white, for: .selected)
            btn.titleLabel?.font = Font.system.bold(withSize: 15)
            btn.backgroundColor = boxColor
            btn.cornerRadius = 5
            btn.contentEdgeInsets = .all(10)
            btn.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(btn)
        }
        
        indicatorView = UIView()
        indicatorView.backgroundColor = indicatorColor
        indicatorView.cornerRadius = 1
        addSubview(indicatorView)
        indicatorView.autoSetDimensions(to: CGSize(width: indicatorWidth, height: 3))
        if let first = buttons.first {
            indicatorView.autoAlignAxis(toSuperviewAxis: .horizontal).constant = 15
            verticalConstraint = indicatorView.autoAlignAxis(.vertical, toSameAxisOf: first)
            
            first.isSelected = true
        } else {
            indicatorView.isHidden = true
        }
        
        if titles.count > selectedIndex {
            selectedIndex = Int(selectedIndex)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if hasShadow && shadowView != nil {
            setShadow(offset: CGSize(width: 0, height: -2), color: .gray, opacity: 0.05, blur: 1)
            shadowView.setShadow(offset: CGSize(width: 0, height: 3), color: .gray, opacity: 0.4, blur: 3)
        }
        
        let shouldScroll = !isRolled && scrollView != nil && buttons.count > 0 && scrollView.contentSize.width > 0
        if shouldScroll {
            isRolled = true
            scrollView.scrollToHorizontal(view: buttons[selectedIndex])
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if let index = buttons.firstIndex(of: sender) {
            selectedIndex = index
        }
    }
    
    private func moveIndicator(relativeTo selectedBtn: UIButton, animated: Bool = true) {
        let center = selectedBtn.center
        let moveCenter = CGPoint(x: center.x, y: center.y + 15 + indicatorView.frame.height/2)
        
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorView.center = moveCenter
            }) { _ in
                self.updateVerticalConstraint(to: selectedBtn)
            }
        } else {
            updateVerticalConstraint(to: selectedBtn)
        }
    }
    
    private func updateVerticalConstraint(to selectedBtn: UIButton) {
        verticalConstraint?.autoRemove()
        verticalConstraint = indicatorView.autoAlignAxis(.vertical, toSameAxisOf: selectedBtn)
    }
    
    private func updateDistribution() {
        if apportionsSegmentWidthsByContent {
            stackView.distribution = .fillProportionally
        } else {
            stackView.distribution = .fillEqually
        }
    }
}


