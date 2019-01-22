//
//  SKLocalizable+NSObject.swift
//  SKLocalizableTests
//
//  Created by Viktor Olesenko on 22.01.19.
//

import XCTest

import XCTest
@testable import SKLocalizable

class SKLocalizable_NSObject: XCTestCase {
    
    override func setUp() {
        Bundle.localization = testsBundle
    }
    
    // MARK: - UIComponents
    
    func testLabel() {
        let key = "Label.Title"
        
        let label = UILabel.init()
        label.localizationKey = key
        
        XCTAssertEqual(key.localized(), label.text)
        
        Bundle.localization = testsBundleRu
        XCTAssertEqual(key.localized(), label.text)
    }
    
    func testButton() {
        let key = "Button.Title"
        
        let button = UIButton.init()
        button.localizationKey = key
        
        XCTAssertEqual(key.localized(), button.titleLabel?.text)
        
        Bundle.localization = testsBundleRu
        XCTAssertEqual(key.localized(), button.titleLabel?.text)
    }
    
    func testTextField() {
        let key = "TextField.Placeholder"
        
        let textField = UITextField.init()
        textField.localizationKey = key
        
        XCTAssertEqual(key.localized(), textField.placeholder)
        
        Bundle.localization = testsBundleRu
        XCTAssertEqual(key.localized(), textField.placeholder)
    }
    
    func testViewController() {
        let key = "UIViewContr.Title"
        
        let viewController = UIViewController.init()
        viewController.localizationKey = key
        
        XCTAssertEqual(key.localized(), viewController.title)
        
        Bundle.localization = testsBundleRu
        XCTAssertEqual(key.localized(), viewController.title)
    }
    
    func testTabBarItem() {
        let key = "UITabBarItem.Title"
        
        let tabBarItem = UITabBarItem.init()
        tabBarItem.localizationKey = key
        
        XCTAssertEqual(key.localized(), tabBarItem.title)
        
        Bundle.localization = testsBundleRu
        XCTAssertEqual(key.localized(), tabBarItem.title)
    }
    
    func testBarButtonItem() {
        let key = "UIBarButtonItem.Title"
        
        let barButton = UIBarButtonItem.init()
        barButton.localizationKey = key
        
        XCTAssertEqual(key.localized(), barButton.title)
        
        Bundle.localization = testsBundleRu
        XCTAssertEqual(key.localized(), barButton.title)
    }
    
    // MARK: - Custom component
    
    class CustomObject: NSObject {
        
        var text: String?
        
        open override func localize() {
            self.text = localizationKey?.localized(tableName: self.localizationFile)
        }
    }
    
    func testCustomObject() {
        let key = "Custom.Text"
        
        let custom = CustomObject.init()
        custom.localizationKey = key
        
        XCTAssertEqual(key.localized(), custom.text)
        
        Bundle.localization = testsBundleRu
        XCTAssertEqual(key.localized(), custom.text)
    }
}
