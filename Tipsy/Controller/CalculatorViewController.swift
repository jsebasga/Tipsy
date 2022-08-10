//
//  ViewController.swift
//  Tipsy
//
//  Created by Sebastian Güiza 12-07-2022
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var splitPeople = 2
    var price = 0.0
    var resultFinal = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleLowPor = String(buttonTitle.dropLast())
        let buttonTitleNumber = Double(buttonTitleLowPor)!
        
        tip = buttonTitleNumber / 100
        
        billTextField.endEditing(true)
    }
    
    @IBAction func strepperValueChanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        splitPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        if bill != ""{
            
            price = Double(bill)!
            let result = price * (1 + tip) / Double(splitPeople)
            resultFinal = String(format: "$ %.2f", result)
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult"{
            
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.result = resultFinal
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = splitPeople
        }
    }
}
