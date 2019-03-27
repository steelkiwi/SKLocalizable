//
//  UIViewController+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 01.11.18.
//

import UIKit

extension UIViewController {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    open override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }

    open override func localize() {
        self.title = self.localizationKey?.localized(tableName: self.localizationFile)
    }
}
