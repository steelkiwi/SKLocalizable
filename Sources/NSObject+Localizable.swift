//
//  NSObject+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 01.11.18.
//

import Foundation

fileprivate extension NSObject {
    
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
private var associatedKeyValue      : UInt8 = 1
private var associatedKeySpecific   : UInt8 = 2

@objc
extension NSObject {
    
    /// Name of .strings file
    open var localizationFile: String? {
        get { return self.getStored(key: &associatedKeyTable) }
        set {
            self.setStored(string: newValue, key: &associatedKeyTable)
            
            self.localize()
        }
    }
    
    /// Localization key, which will be used for getting corresponding value from localizationFile.strings
    open var localizationKey: String? {
        get { return self.getStored(key: &associatedKeyValue) }
        set {
            if let _ = newValue {
                subscribeLanguageNotifications()
            } else {
                unsubscribeLanguageNotifications()
            }
            
            self.setStored(string: newValue, key: &associatedKeyValue)
            self.localize()
        }
    }
    
    open func localize() { }
    
    /// Subscribe to .languageChanged notification
    private func subscribeLanguageNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(localize), name: .languageChanged, object: nil)
    }
    
    /// Unsubscribe from .languageChanged notification
    private func unsubscribeLanguageNotifications() {
        NotificationCenter.default.removeObserver(self, name: .languageChanged, object: nil)
    }    
}
