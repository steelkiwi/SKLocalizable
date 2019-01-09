//
//  ViewController.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 01.10.18.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var label1       : UILabel!      // Set key in code
    @IBOutlet weak var label2       : UILabel!      // Set key in IB
    @IBOutlet weak var button       : UIButton!     // Set key in IB
    @IBOutlet weak var textField1   : UITextField!  // Set key in IB
    @IBOutlet weak var textField2   : UITextField!  // Set value manually in code
        
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Option 1 - Preferred way
        // Set text via localizationKey. This way will call all localization triggers
        label1.localizationKey = "DemoVC.CodeLabel.Text"
        
        // Option 2
        // Set text directly - you should handle any language changes manually
        textField2.text = "DemoVC.TextField.Text".localized()
        
        // Manually handle language change event via ".languageChanged" notification
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged(_:)), name: .languageChanged, object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction
    private func changeLanguage(_ sender: UIButton) {
        guard let lng = Language(tag: sender.tag) else { return }
        
        Bundle.localization = Bundle.init(languageCode: lng.languageCode) ?? .main
    }
    
    @objc
    private func languageChanged(_ notification: Notification) {
        textField2.text = "DemoVC.TextField.Text".localized()
    }
}

private extension Language {
    
    init?(tag: Int) {
        if Language.allCases.count > tag {
            self = Language.allCases[tag]
        } else {
            return nil
        }
    }
    
    var tag: Int {
        return Language.allCases.firstIndex(of: self)!
    }
    
    var languageCode: String {
        switch self {
        case .english: return "en"
        case .russian: return "ru"
        }
    }
}
