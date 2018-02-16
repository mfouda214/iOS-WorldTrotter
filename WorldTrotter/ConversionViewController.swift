//
//  ConversionViewController.swift
//  WorldTrotter
//  Development Mode
//  Created by Mohamed Sobhi  Fouda on 2/15/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
   
    //NumberFormatter
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
        }()
    
    override func viewWillAppear(_ animated: Bool) {
        // Get the current hour and see if it's past 6
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH"
        if let hour = Int(formatter.string(from: now)) {
            if hour > 18 || hour < 6 {
                // originalColor = "F5F4F1"
                self.view.backgroundColor = UIColor.gray
            } else {
                self.view.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        // Do any additional setup after loading the view, typically from a nib.
        updateCelsiusLabel()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var celsiusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        //Add a property observer to fahrenheitValue that gets called after the property value changes
        didSet {
            updateCelsiusLabel()
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        /*
          // simultinuos change
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = text
        } else {
            celsiusLabel.text = "???"
        }
        */
        
        // check if entered text can be double
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text =
                numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    
}

extension ConversionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                      shouldChangeCharactersIn range: NSRange,
                      replacementString string: String) -> Bool {

        /*
        // these commented code print to console current and replacment text
        print("Current text: \(String(describing: textField.text))")
        print("Replacement text: \(string)")

        return true
        */

        // reject Alphapatics
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789.")
        let replacementStringCharacterSet = CharacterSet(charactersIn: string)
        if !replacementStringCharacterSet.isSubset(of: allowedCharacterSet) {
            print("Rejected (Invalid Character) \"\(string)\"")
            return false
        }

        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")

        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            print("Current text: \(String(describing: textField.text))")
            print("rejected extra decimal point \"\(string)\"")
            return false
        } else {
            return true
        }
    }
    
    
}
