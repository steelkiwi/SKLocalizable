//
//  UISearchBar+Localizable.swift
//  SKLocalizable
//
//  Created by Artem Zinuk on 25.02.19.
//

import UIKit

extension UISearchBar {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    open override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }
    
    open override func localize() {
        DispatchQueue.main.async {
            self.placeholder = self.localizationKey?.localized(tableName: self.localizationFile)
        }
    }
}
