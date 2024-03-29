//
//  ViewController.swift
//  Easy Tip
//
//  Created by Ana Araujo on 16/07/2022.
//  Copyright © 2022 Ana Araujo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTotalInput: UITextField!
    
    @IBOutlet weak var firstPctButton: UIButton!
    @IBOutlet weak var secPctButton: UIButton!
    @IBOutlet weak var thirdPctButton: UIButton!
    @IBOutlet weak var otherPctInput: UITextField!

    @IBOutlet weak var numPplLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
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
        numberOfPeople = Int(sender.value)
        numPplLabel.text = "\(numberOfPeople)"
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
        }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        billTotalInput.text = nil
        otherPctInput.text = nil
        billTotalInput.isEnabled = true
        firstPctButton.isSelected = false
        thirdPctButton.isSelected = false
        numPplLabel.text = "1"
        stepper.value = 1

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResults" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.billEach = String(format: "%.2f", billTotal / Double(numberOfPeople))
            if (otherPctInput.text != "") {
                destinationVC.tipEach = String(format: "%.2f", (billTotal * (1 + Double(otherPctInput.text!)! / 100) - billTotal) /  Double(numberOfPeople))
                destinationVC.tipPct = Int(otherPctInput.text!)!
            } else {
                destinationVC.tipEach = String(format: "%.2f", (billTotal * (1 + tip) - billTotal) /  Double(numberOfPeople))
                destinationVC.tipPct = Int(tip * 100)
            }
            destinationVC.split = numberOfPeople
            
        }
    }
}
