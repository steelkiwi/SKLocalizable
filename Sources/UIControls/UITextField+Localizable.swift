//
//  UITextField+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import UIKit

public extension UITextField {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    public override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }
    
    public override func localize() {
        self.placeholder = localizationKey?.localized(tableName: self.localizationFile)
    }
}

