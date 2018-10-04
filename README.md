# SKLocalizable

## Requirements

- iOS 9.0+
- Swift 4.1+

## 1. Installation

### 1.1 CocoaPods

```ruby
pod 'SKLocalizable', :git => "https://github.com/steelkiwi/SKLocalizable.git"
```

### 1.2 Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/steelkiwi/SKLocalizable.git", from: "1.0.1")
]
```

### 1.3 Manually

Just copy `Sources` Folder to your Project


## 2. Usage

### 2.1. Localizable.strings

**Localizable.strings forming rules:**

```
/*
 * 1. Group logic blocks to sections. Ex: Enums, Errors, Screens, etc
 *
 * 2. Section name format:
 *      // ======
 *      // 'MARK: - Section Name
 *      // ======
 *
 * 3. Separate subsections using 2 newlines and MARK
 *
 * 4. Lines format:
 *      /*  *'/ - comment about string
 *      "Key" = "Value";
 *
 *      Optional: 'Key' should contain name of screen and identifier (any number of words), separated with "." symbol
 *
 * 5. Parameters in strings should be named using format:
 *      $(ParameterNameKey) - it will be automatically replaced with value from passed dict while localization
 *
 * 6. Localize plural numbers in Localizable.stringsdict
 *      How to use plural localization - https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/StringsdictFileFormat/StringsdictFileFormat.html
 *      Plural rules - http://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html
 */
``` 

**Localizable.strings file example:**

```
// ======
// 'MARK: - Demo screen
// ======


// MARK - Language Buttons

/* Button, that switches to English language */
"DemoVC.LanguageButton.English" = "English";

/* Button, that switches to Russian language */
"DemoVC.LanguageButton.Russian" = "Русский";


// MARK - UI Components

/* Label, whose text value is set in the code */
"DemoVC.CodeLabel.Text" = "Label - Code";

/* Label, whose text value is set in the IB file */
"DemoVC.IBLabel.Text" = "Label - Storyboard";

/* Button, whose title value is set in the IB file */
"DemoVC.Button.Title" = "Button - Storyboard";

/* TextField, whose placeholder value is set in the IB file */
"DemoVC.TextField.Placeholder" = "TextField - Storyboard - Placeholder";

/* TextField, whose text value is set in the code */
"DemoVC.TextField.Text" = "TextField - Code - Text";
```

### 2.2. Localization File

`localizationFile` value is using for defining specific `.strings` file.

Default value is `nil`, so `Localizable.strings` file will be used


### 2.3. Localization Key

Use one of described options for components localization:

- Set `localizationKey` in IB:  
	![Screenshot](https://user-images.githubusercontent.com/15200601/46483808-308efd80-c801-11e8-8b4c-74f5d728e498.png)
	
- Set `localizationKey` manually in code:

```swift
label.localizationKey = "DemoVC.CodeLabel.Text"
```

### 2.4. Localized Value

You can set localized value directly in code, using String `localized` method:

```swift
/// Get self as key and return related localized value
///
/// - Parameter tableName: .strings file name
/// - Parameter bundle: language bundle, from where should be taken value. Default is Bundle.localiztion
/// - Parameter arguments: JSON, where:
///     - key - is key in localized string value from .strings file
///     - value - string, which will be used for replacing key in localized string
/// - Returns: localized value if found. Key (self) otherwise
public func localized(tableName: String? = nil, bundle: Bundle = .localization, arguments: Dictionary<String, Any>? = nil) -> String
```

Example:
`textField.text = "DemoVC.TextField.Text".localized()`


### 2.5. Localized Plural value

If you need to use plurals in your project, use String method `localizedPlural`:

```swift
/// Load formatted string value from tableName.stringsDict and paste arguments at corresponding places in format string
///
/// - Parameter tableName: .strings file name
/// - Parameter arguments: set of parameters, which should be use for plural replacement
public func localizedPlural(tableName: String? = nil, arguments: CVarArg...) -> String {
    return String.localizedStringWithFormat(self.localized(tableName: tableName), arguments)
}
```

Example:  
"Localizable.stringsdict" contains next key:

```
<key>Date.UnitPlural.Hour</key>
<dict>
    <key>NSStringLocalizedFormatKey</key>
    <string>%#@hours@</string>
    <key>hours</key>
    <dict>
        <key>NSStringFormatSpecTypeKey</key>
        <string>NSStringPluralRuleType</string>
        <key>NSStringFormatValueTypeKey</key>
        <string>d</string>
        <key>one</key>
        <string>%d hour</string>
        <key>other</key>
        <string>%d hours</string>
    </dict>
</dict>
```

Usage: `"Date.UnitPlural.Hour".localizedPlural(arguments: hoursIntValue)`  


`Date.UnitPlural.Hour` will return "%d hour" string if `hoursIntValue` == 1 and "%d hours" otherwise. After that, value `hoursIntValue` will be inserted at  `%d` place and we will receive result string "1 hour" / "5 hours"

Useful links about plurals:

- [How to use plural localization](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/StringsdictFileFormat/StringsdictFileFormat.html)
- [Plural rules](http://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html)


### 2.6. NotificationCenter - `languageChanged` notification

For language changing use **Bundle.localization**. It's default value is .main

Setting new language: `Bundle.localization = Bundle.init(languageCode: languageCode)`

Where `languageCode` is 2-symbol presentation of language. If you not sure about code, you can take it from `.lproj` folder name after new project language adding

When new value was set, `languageChanged`, notification will be send via `NotificationCenter.default`

Components with defined `localizationKey` will change their value automatically

You can also subscribe to `languageChanged` notification and handle this event manually: 

```swift
NotificationCenter.default.addObserver(self, selector: #selector(languageChanged(_:)), name: .languageChanged, object: nil)
```

```swift
@objc
private func languageChanged(_ notification: Notification) {
    // Manually set localized values
}
```

## 3 Components

`UIView` implemented `Localizable` protocol, so any it's subclass can expand localization functionality

### 3.1 Componentes, localized out of the box

There are exist already localized components:

- UILabel - `text`
- UIButton - `title`
- UITextField - `placeholder`

All mentioned components implements required method `localize` in which they set localized text to corresponding property in required way. 

Example of UILabel implementation: 

```swift
@objc
public override func localize() {
    self.text = localizationKey?.localized(tableName: self.localizationFile)
}
```

Also this components overrides `localizationKey` property of `UIView`. The main purpose of this override - is make property `IBInspectable`


### 3.2 Addinitonal / Custom components

You can easily append `Localizable` behaviour to any your component:

- If component is a subclass of `UIView`, just make an extension, which will override `localize` method and will set localized value to corresponding field of your component.  
Also you can add `IBInspectable` attributes to `localizationKey` or `localizationFile ` via overriding (check [UILabel+Localizable.swift](https://github.com/steelkiwi/SKLocalizable/blob/master/Source/UILabel+Localizable.swift) file for example)

- If component isn't a subclass of `UIView`, please duplicate [UIView+Localizable.swift](https://github.com/steelkiwi/SKLocalizable/blob/master/Source/UIView +Localizable.swift) implementation for `Localizable` protocol conformance

## License

SKLocalizable is released under the [MIT license](https://github.com/steelkiwi/SKLocalizable/blob/master/LICENSE) for details.

<sub>Created by Viktor Olesenko on 03.10.18</sub>