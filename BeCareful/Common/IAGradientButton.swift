//
//  IAGradientButton.swift
//  BeCareful
//
//  Created by Mariana Parente on 29/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//

import UIKit

@IBDesignable class IAGradientButton: UIButton {

    // MARK: Properties

    @IBInspectable var roundness: CGFloat = 0.0 {
        didSet { setup() }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { setup() }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet { setup() }
    }

    @IBInspectable var initialGradientColor: UIColor = UIColor.smBlue {
        didSet { setup() }
    }

    @IBInspectable var endGradientColor: UIColor = UIColor(red: 39.0 / 255.0, green: 151.0 / 255.0, blue: 217.0 / 255.0, alpha: 1) {
        didSet { setup() }
    }

    @IBInspectable var pressedColor: UIColor = UIColor(red: 0, green: 110.0 / 255.0, blue: 176.0 / 255.0, alpha: 1) {
        didSet { setup() }
    }

    override var bounds: CGRect {
        get { return super.bounds }
        set {
            super.bounds = newValue
            setup()
            setNeedsLayout()
        }
    }

    private var gradient: CAGradientLayer!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    // MARK: - Actions
    @objc func buttonHighlight(_ sender: UIButton) {
        gradient.colors = [pressedColor.cgColor, pressedColor.cgColor]
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.beginFromCurrentState], animations: {
            let transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
            self.layer.setAffineTransform(transform)
        }, completion: nil)
    }

    @objc func buttonNormal(_ sender: UIButton) {
        gradient.colors = [initialGradientColor.cgColor, endGradientColor.cgColor]
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.beginFromCurrentState], animations: {
            let transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.layer.setAffineTransform(transform)
        }, completion: nil)
    }

    // MARK: - Private Methods

    private func configure() {
        addTarget(self, action: #selector(buttonHighlight(_:)), for: .touchDown)
        addTarget(self, action: #selector(buttonHighlight(_:)), for: .touchDragInside)
        addTarget(self, action: #selector(buttonHighlight(_:)), for: .touchDragEnter)
        addTarget(self, action: #selector(buttonNormal(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(buttonNormal(_:)), for: .touchUpOutside)
        addTarget(self, action: #selector(buttonNormal(_:)), for: .touchDragExit)
        addTarget(self, action: #selector(buttonNormal(_:)), for: .touchDragOutside)

        gradient = CAGradientLayer()
        gradient.colors = [initialGradientColor.cgColor, endGradientColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = bounds
        layer.addSublayer(gradient)
        bringSubviewToFront(titleLabel!)
        bringSubviewToFront(imageView!)
    }

    private func setup() {
        super.layoutSubviews()

        //Add border
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor

        //Add background
        layer.backgroundColor = initialGradientColor.cgColor
        clipsToBounds = true

        //Add Gradient
        gradient.frame = bounds
        gradient.colors = [initialGradientColor.cgColor, endGradientColor.cgColor]
        layer.cornerRadius = roundness
    }
}
