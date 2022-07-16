//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTotalInput: UITextField!
    
    @IBOutlet weak var firstPctButton: UIButton!
    @IBOutlet weak var secPctButton: UIButton!
    @IBOutlet weak var thirdPctButton: UIButton!
    
    @IBOutlet weak var otherPctInput: UITextField!

    @IBOutlet weak var numPplLabel: UILabel!
    
    /*@IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!*/
    
    var tip = 0.15
    var numberOfPeople = 1
    var billTotal = 0.0
    var finalResult = "0.0"
    
    
    @IBAction func tipValChanged(_ sender: UIButton) {
        billTotalInput.endEditing(true)
        
        firstPctButton.isSelected = false
        secPctButton.isSelected = false
        thirdPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        otherPctInput.isEnabled = false
        
        numPplLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        let bill = billTotalInput.text!
        if bill != "" {
            billTotal = Double(bill)!
            var result: Double
            if otherPctInput.text == "" {
                result = billTotal * (1 + tip) / Double(numberOfPeople)
            } else {
                result = billTotal * (1 + (Double(otherPctInput.text!)! / 100)) / Double(numberOfPeople)
            }
            finalResult = String(format: "%.2f", result)
            print(finalResult)
        }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        billTotalInput.text = nil
        otherPctInput.text = nil
        billTotalInput.isEnabled = true
        firstPctButton.isSelected = false
        thirdPctButton.isSelected = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResults" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}
