//
//  IAUIView.swift
//  BeCareful
//
//  Created by Mariana Parente on 29/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//  swiftlint:disable force_cast
//

import UIKit

@IBDesignable
class IAUIView: UIView {

    // MARK: Properties
    var view: UIView!

    // MARK: - Init
    required override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }

    // MARK: - Private Methods
    private func viewSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        guard let className = String(describing: type(of: self)).components(separatedBy: ".").last else { return self }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        let view = views.first as! UIView
        return view
    }
}
