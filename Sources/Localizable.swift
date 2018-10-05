//
//  Localizable.swift
//  LocaliseTest
//
//  Created by Viktor Olesenko on 01.11.17.
//  Copyright © 2017 Viktor Olesenko. All rights reserved.
//

import UIKit

public protocol Localizable {
    
    /// Name of localization file. Set nil for default 'Localizable.strings'
    var localizationFile: String? { get set }
    
    /// Key for localization value
    var localizationKey:  String? { get set }
    
    /// Setting value, according to localizationKey in this method
    func localize()
}

public extension Localizable {
    
    /// Subscribe to .languageChanged notification
    func subscribeLanguageNotifications() {}
    
    /// Unsubscribe from .languageChanged notification
    func unsubscribeLanguageNotifications() {}
}
