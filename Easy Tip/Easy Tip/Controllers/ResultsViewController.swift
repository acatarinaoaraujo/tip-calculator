//
//  ResultsViewController.swift
//  Easy Tip
//
//  Created by Ana Araujo on 16/07/2022.
//  Copyright © 2022 Ana Araujo. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //@IBOutlet weak var totalLabel: UILabel!
    //@IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var billPersonLabel: UILabel!
    @IBOutlet weak var tipPersonLabel: UILabel!
    @IBOutlet weak var totalPersonLabel: UILabel!
    @IBOutlet weak var extraInfroLabel: UILabel!
    
    var split = 1
    var billEach = "0.0"
    var tipEach = "0.0"
    var tipPct = 10
    var result = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billPersonLabel.text = billEach
        tipPersonLabel.text = tipEach
        totalPersonLabel.text = result
        extraInfroLabel.text = "Number of \(split) people, with \(tipPct)% tip."

    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
