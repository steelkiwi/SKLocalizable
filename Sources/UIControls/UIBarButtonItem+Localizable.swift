//
//  UIBarButtonItem+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 10.01.19.
//

import UIKit

extension UIBarButtonItem {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    open override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }
    
    open override func localize() {
        DispatchQueue.main.async {
            self.title = self.localizationKey?.localized(tableName: self.localizationFile)
        }
    }
}
