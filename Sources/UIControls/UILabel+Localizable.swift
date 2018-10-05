//
//  UILabel+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import UIKit

public extension UILabel {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    open override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }
    
    @objc
    open override func localize() {
        self.text = localizationKey?.localized(tableName: self.localizationFile)
    }
}
