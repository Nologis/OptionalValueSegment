//
//  DisabledSegment.swift
//  DisabledSegment
//
//  Created by vgutierrezNologis on 30/8/18.
//  Copyright © 2018 vgutierrezNologis. All rights reserved.
//

import UIKit

struct OptionalValueSegmentAppearance {
    /// Colors
    var selectedColor = UIColor.black
    var defaultColor = UIColor.darkGray
    var backgroundColor = UIColor.white
    /// Font
    var font = UIFont.systemFont(ofSize: 17, weight: .regular)
    var defaultTextColor = UIColor.black
    var selectedTextColor = UIColor.white
    /// Sizes
    var borderWidth = CGFloat(5)
    var cornerRadius = CGFloat(8)
}

class OptionalValueSegment: UIView {
    var appearance = OptionalValueSegmentAppearance() {
        didSet {
            applyAppearance()
        }
    }
    var options: [(String, Any)] = [("Yes", true), ("No", false)] {
        didSet {
            subviews.forEach { (view) in
                view.removeFromSuperview()
            }
            optionsButtons = []
            buildViews()
        }
    }
    private var optionsButtons = [UIButton]()
    private var selectedOptionIndex: Int? = nil {
        didSet {
            if self.selectedOptionIndex == nil {
                backgroundColor = appearance.defaultColor
                layer.borderColor = appearance.defaultColor.cgColor
            } else {
                backgroundColor = appearance.selectedColor
                layer.borderColor = appearance.selectedColor.cgColor
            }
            for index in 0...options.count-1 {
                let optionButton = optionsButtons[index]
                if self.selectedOptionIndex == nil {
                    optionButton.setTitleColor(appearance.defaultColor, for: .normal)
                    optionButton.backgroundColor = appearance.backgroundColor
                } else {
                    optionButton.setTitleColor(index == selectedOptionIndex
                        ? appearance.selectedTextColor
                        : appearance.defaultTextColor,
                        for: .normal
                    )
                    optionButton.backgroundColor = index == selectedOptionIndex
                        ? appearance.selectedColor
                        : appearance.backgroundColor
                }
            }
        }
    }
    var selectedValue: Any? {
        guard let index = selectedOptionIndex else {
            return nil
        }
        let (_, value) = options[index]
        return value
    }

    // MARK: Init & Lifecycle
    init(frame: CGRect,
         options: [(String, Any)],
         appearance: OptionalValueSegmentAppearance?
        ) {
        self.options = options
        self.appearance = appearance ?? OptionalValueSegmentAppearance()
        super.init(frame: frame)
        buildViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }

    // MARK: Views creation
    func buildViews() {
        clipsToBounds = true
        let optionWidth = (bounds.width - (CGFloat(options.count)+2 * appearance.borderWidth)) / CGFloat(options.count)
        let optionHeight = bounds.height - 2 * appearance.borderWidth
        for index in 0...options.count-1 {
            let (text, _) = options[index]
            let fIndex = CGFloat(index)
            let optionButton = UIButton(frame:
                CGRect(
                    x: appearance.borderWidth + fIndex * (appearance.borderWidth + optionWidth),
                    y: appearance.borderWidth,
                    width: optionWidth,
                    height: optionHeight
                )
            )
            optionButton.tag = index
            optionButton.setTitle(
                text,
                for: .normal
            )
            optionButton.addTarget(self, action: #selector(optionTouch(_:)), for: .touchUpInside)
            addSubview(optionButton)
            optionsButtons.append(optionButton)
        }
        applyAppearance()
    }
    private func applyAppearance() {
        layer.borderWidth = appearance.borderWidth
        layer.borderColor = appearance.defaultColor.cgColor
        layer.cornerRadius = appearance.cornerRadius
        backgroundColor = appearance.defaultColor
        for index in 0...options.count-1 {
            let optionButton = optionsButtons[index]
            optionButton.titleLabel?.font = appearance.font
            optionButton.setTitleColor(appearance.defaultColor, for: .normal)
            optionButton.backgroundColor = appearance.backgroundColor
        }
        self.setNeedsDisplay()
    }
    func reset() {
        selectedOptionIndex = nil
    }
    // MARK: IBActions
    @IBAction func optionTouch(_ optionButton: UIButton) {
        selectedOptionIndex = optionButton.tag
    }
}
