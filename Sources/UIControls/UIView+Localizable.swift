//
//  UIView+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import UIKit

private extension Localizable {
    
    /// Subscribe to .languageChanged notification
    func subscribeLanguageNotifications() {}
    
    /// Unsubscribe from .languageChanged notification
    func unsubscribeLanguageNotifications() {}
}

fileprivate extension UIView {
    
    /// Link and save passed string to 'self' with key
    func setStored(string: String?, key: UnsafePointer<UInt8>) {
        objc_setAssociatedObject(self, key, string, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// Get saved string from 'self' for key
    func getStored(key: UnsafePointer<UInt8>) -> String? {
        return objc_getAssociatedObject(self, key) as? String
    }
}

// Should be defined as private vars for current value storing
private var associatedKeyTable      : UInt8 = 0
private var associatedKeyText       : UInt8 = 1
private var associatedKeySpecific   : UInt8 = 2

@objc
extension UIView: Localizable {
    
    /// Name of .strings file
    public var localizationFile: String? {
        get { return self.getStored(key: &associatedKeyTable) }
        set {
            self.setStored(string: newValue, key: &associatedKeyTable)
            
            self.localize()
        }
    }
    
    /// Localization key, which will be used for getting corresponding value from localizationFile.strings
    public var localizationKey: String? {
        get { return self.getStored(key: &associatedKeyText) }
        set {
            if let _ = newValue {
                subscribeLanguageNotifications()
            } else {
                unsubscribeLanguageNotifications()
            }
            
            self.setStored(string: newValue, key: &associatedKeyText)
            self.localize()
        }
    }
    
    public func localize() { }
    
    private func subscribeLanguageNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(localize), name: .languageChanged, object: nil)
    }
    
    private func unsubscribeLanguageNotifications() {
        NotificationCenter.default.removeObserver(self, name: .languageChanged, object: nil)
    }
}
