//
//  String+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import Foundation

public extension String {
    
    /// Get self as key and return related localized value
    ///
    /// - Parameter tableName: .strings file name
    /// - Parameter bundle: language bundle, from where should be taken value. Default is Bundle.localiztion
    /// - Parameter arguments: JSON, where:
    ///     - key - is parameter key in localized string value from .strings file
    ///     - value - value, which will be used for replacing key in localized string. Should conforms to [String convertible](https://developer.apple.com/documentation/swift/string/2427941-init)
    /// - Returns: localized value if found. Key (self) otherwise
    public func localized(tableName: String? = nil, bundle: Bundle = .localization, arguments: Dictionary<String, Any>? = nil) -> String {
        
        var localizedValue = NSLocalizedString("\(self)", tableName: tableName, bundle: bundle, comment: "") // Wrapped self into string for localization export support
        
        // Check if value contains parameters
        if let keysToReplace = keys(from: localizedValue) {
            
            // Check if any parameters was passed
            guard let arguments = arguments else {
                assertionFailure("Localized value requires arguments")
                return localizedValue
            }
            
            for key in keysToReplace {
                
                // Check if required parameter was passed
                guard arguments.keys.contains(key) else {
                    assertionFailure("Arguments doesn't contain required key '\(key)'")
                    continue
                }
                
                // Nil values aren't supported
                guard let value = arguments[key] else {
                    assertionFailure("Nil value passed for key '\(key)'")
                    continue
                }
                
                let keyString   = "$(\(key))"
                let valueString = String.init(describing: value)
                
                localizedValue = localizedValue.replacingOccurrences(of: keyString, with: valueString)
            }
        }
        
        return localizedValue
    }
    
    private func keys(from string: String) -> Array<String>? {
        var foundKeys: Array<String>?
        
        let pattern = "\\$\\([\\S][^\\$]*\\)"
        let regex = try! NSRegularExpression.init(pattern: pattern)
        
        regex.matches(in: string, range: NSRange.init(location: 0, length: string.count)).forEach { (keyRange) in
            let wrappedKey = (string as NSString).substring(with: keyRange.range)
            
            let startIndex = wrappedKey.index(wrappedKey.startIndex, offsetBy: 2) // Drop "$("
            let endIndex   = wrappedKey.index(wrappedKey.endIndex, offsetBy: -1) // Drop ")"
            
            let key = wrappedKey[startIndex ..< endIndex]
            
            if foundKeys == nil { foundKeys = [] }
            
            foundKeys?.append(String(key))
        }
        
        return foundKeys
    }
    
    /// Load formatted string value from tableName.stringsDict and paste arguments at corresponding places in format string
    ///
    /// - Parameter tableName: .strings file name
    /// - Parameter arguments: set of parameters, which should be use for plural replacement
    /// Example: "Date.UnitPlural.Hour" key -> "%d hour" value for argument "1" -> put argument at "%d" place -> returns "1 hour" result string
    public func localizedPlural(tableName: String? = nil, arguments: CVarArg...) -> String {
        return String.init(format: self.localized(), arguments: arguments)
    }
}
