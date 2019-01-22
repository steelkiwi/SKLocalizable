//
//  SKLocalizableTests.swift
//  SKLocalizableTests
//
//  Created by Viktor Olesenko on 22.01.19.
//

import XCTest
@testable import SKLocalizable

class SKLocalizableTests: XCTestCase {

    override func setUp() {
        Bundle.localization = testsBundle
    }
    
    // MARK: - Table (.strings file)
    
    func testTableDefault() {
        XCTAssertEqual("Localizable", "Filename".localized())
    }
    
    func testTableNamed() {
        XCTAssertEqual("Localizable", "Filename".localized(tableName: "Localizable"))
        XCTAssertEqual("Localizable2", "Filename".localized(tableName: "Localizable2"))
    }

    // MARK: - Lng change
    
    func testLngChange() {
        XCTAssertEqual("Localizable", "Filename".localized())
        
        Bundle.localization = testsBundleRu        
        XCTAssertEqual("Localizable_ru", "Filename".localized())
    }
    
    // MARK: - Simple string value
    
    func testSimple() {
        XCTAssertEqual("Simple", "String.Simple".localized())
    }
    
    func testSimpleParameterizedSingle() {
        let valueSingle = [
            "value" : "value"
        ]
        
        let expectedValue = valueSingle.values.first!
        
        XCTAssertEqual(expectedValue, "String.Parameterized.One".localized(arguments: valueSingle))
    }
    
    func testSimpleParameterizedMultiple() {
        let valueMultiple = [
            "value_1" : "First",
            "value_2" : "Second"
        ]
        
        let expectedValue = "\(valueMultiple["value_1"]!),\(valueMultiple["value_2"]!)" // Created manually, bcs `.joined` can mix order
        
        XCTAssertEqual(expectedValue, "String.Parameterized.Multiple".localized(arguments: valueMultiple))
    }
    
    // MARK: - Plural string value
    
    func testPluralSingleZero() {
        let value = 0
        
        let expectedValue = "Zero \(value)"
        XCTAssertEqual(expectedValue, "String.Plural".localizedPlural(arguments: value))
    }
    
    func testPluralSingleOne() {
        let value = 1
        
        let expectedValue = "One \(value)"
        XCTAssertEqual(expectedValue, "String.Plural".localizedPlural(arguments: value))
    }
    
    func testPluralSingleMultiple() {
        let value = 5
        
        let expectedValue = "Multiple \(value)"
        XCTAssertEqual(expectedValue, "String.Plural".localizedPlural(arguments: value))
    }
}
