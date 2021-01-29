//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    Header Objects
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
//    Input Card Objects
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!

//    Output Card Objects
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
//    Reset Button
    @IBOutlet weak var resetButton: UIButton!
    
    // Make the status bar match theme
    var isDefaultStatusBar = true
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDefaultStatusBar ? .default : .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setTheme(isDark: false)
        
        billAmountTextField.calculateButtonAction = {
            self.calculate()
        }
    }
    
    func setupViews() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        inputCardView.layer.cornerRadius = 8
        inputCardView.layer.masksToBounds = true
        
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        outputCardView.layer.borderWidth = 1
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor
        
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
    }
    
    func setTheme(isDark: Bool) {
        // if Dark, set local theme variable to the dark Color Theme defined in ColorTheme.swift. Else, set it to light
        let theme = isDark ? ColorTheme.dark : ColorTheme.light
        
        isDefaultStatusBar = theme.isDefaultStatsBar
        // Beautiful innate function to tell the ViewController that the status bar's properties have been updated
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = theme.viewControllerBackgroundColor
        
        headerView.backgroundColor = theme.primaryColor
        titleLabel.textColor = theme.primaryTextColor
        
        inputCardView.backgroundColor = theme.secondaryColor
        
        billAmountTextField.tintColor = theme.accentColor
        tipPercentSegmentedControl.tintColor = theme.accentColor
        
        outputCardView.backgroundColor = theme.primaryColor
        outputCardView.layer.borderColor = theme.accentColor.cgColor
        
        tipAmountTitleLabel.textColor = theme.primaryTextColor
        totalAmountTitleLabel.textColor = theme.primaryTextColor
        
        tipAmountLabel.textColor = theme.outputTextColor
        totalAmountLabel.textColor = theme.outputTextColor
        
        resetButton.backgroundColor = theme.secondaryColor
    }
    
    func calculate() {
        // Dismiss the keyboard if it's still being displayed
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder()
        }
        
        // Catch bill amount text and turn it into a double
        // Reset if input is invalid
        guard let billAmountText = self.billAmountTextField.text, let billAmount = Double(billAmountText) else {
            clear()
            return
        }
        
        let roundedBillAmount = (100 * billAmount).rounded() / 100
        
        // Get Tip Input from Segmented Control
        let tipPercent: Double
        switch tipPercentSegmentedControl.selectedSegmentIndex {
        case 0:
            tipPercent = 0.15
        case 1:
            tipPercent = 0.18
        case 2:
            tipPercent = 0.20
        default:
            preconditionFailure("Unexpected index.")
        }
        
        
        // Calculate Tip
        let tipAmount = roundedBillAmount * tipPercent
        let roundedTipAmount = (100 * tipAmount.rounded()) / 100
        
        // Calculate Total
        let totalAmount = roundedTipAmount + roundedBillAmount
        
        
        // Update UI values with calculated values
        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
        self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount)
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
//            debug
            print("Bill Amount: \(roundedBillAmount)")
            print("Tip Amount: \(roundedTipAmount)")
            print("Toal Amount: \(totalAmount)")
    }
    
    // For the reset button or if calculator gets an invalid input
    func clear() {
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
    }
    
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        
        // Call setTheme function, if switch is toggled on, dark mode is turned on
        setTheme(isDark: sender.isOn)
        
        // debug
        if sender.isOn {
            print("Dark mode toggled on")
        } else {
            print("Dark mode toggled off")
        }
    }
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
        // debug
        print("Tip Percent Changed. Calculate Function Called")
    }
    @IBAction func resetButtonTapped(_ sender: Any) {
        clear()
        
        // debug
        print("Reset Button Tapped")
    }
}

