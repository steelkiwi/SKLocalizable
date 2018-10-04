//
//  UIButton+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import UIKit

public extension UIButton {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    public override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }
    
    public override func localize() {
        // Setting directly in textLabel first to avoid text change animation
        self.titleLabel?.text = localizationKey?.localized(tableName: self.localizationFile)
        self.setTitle(localizationKey?.localized(tableName: self.localizationFile), for: .normal)
    }
}
