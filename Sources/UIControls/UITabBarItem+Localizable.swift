//
//  UITabBarItem+Localizable.swift
//  SKLocalizable
//
//  Created by Artem Zinuk on 09.01.19.
//

import UIKit

extension UITabBarItem {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    open override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }
    
    open override func localize() {
        self.title = localizationKey?.localized(tableName: self.localizationFile)
    }
}
