//
//  ExchangeViewController.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 09/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chooseCurrencyData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return chooseCurrencyData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if firstCurrency.state == .selected { firstCurrency.setTitle(chooseCurrencyData[row], for: .normal)
            firstCurrency.isSelected = false
        }
        if secondCurrency.state == .selected {
        secondCurrency.setTitle(chooseCurrencyData[row], for: .normal)
            secondCurrency.isSelected = false
        }
        chooseCurrency.isHidden = true
    }

    @IBOutlet weak var firstCurrency: UIButton!
    @IBOutlet weak var secondCurrency: UIButton!
    @IBOutlet weak var firstCurrencyExchange: UITextField!
    @IBOutlet weak var secondCurrencyExchange: UITextField!
    @IBOutlet weak var chooseCurrency: UIPickerView!
    var chooseCurrencyData : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseCurrency.isHidden = true
        self.chooseCurrency.delegate = self
        self.chooseCurrency.dataSource = self
        chooseCurrencyData = ["Australian Dollar", "Canadian Dollar", "Swiss Franc", "Euro", "British Pound Sterling", "Japanese Yen", "United States Dollar"]
    }
    
    @IBAction func currencyOne(_ sender: UIButton) {
        chooseCurrency.isHidden = false
        firstCurrency.isSelected = true
    }
    @IBAction func currencyTwo(_ sender: UIButton) {
        chooseCurrency.isHidden = false
        secondCurrency.isSelected = true
    }
    @IBAction func exchange(_ sender: UIButton) {
        ExchangeService.getExchange(completionHandler: { (rate, error) in
            self.calculate(data: rate!)
        })
    }
    
    func calculate (data: ExchangeRate) {
        let currencyOne = ExchangeService.convertFrom(label: firstCurrency.title(for: .normal)!)
        let currencyTwo = ExchangeService.convertFrom(label: secondCurrency.title(for: .normal)!)
        if currencyOne == data.base || currencyTwo == data.base {

            if currencyOne == data.base {
                let text = firstCurrencyExchange.text!
                let value = Double(text)!
//                let result = "\(value * data.rates[currencyTwo]!)"
//                secondCurrencyExchange.text = String(format:"%.2f", result)
                secondCurrencyExchange.text = "\(value * data.rates[currencyTwo]!)"
            } else {
                let text = firstCurrencyExchange.text!
                let value = Double(text)!
//                let result = "\(value * (1 / (data.rates[currencyOne]!)))"
//                secondCurrencyExchange.text = String(format:"%.2f", result)
                secondCurrencyExchange.text = "\(value * (1 / (data.rates[currencyOne]!)))"
            }
        } else {

            let text = firstCurrencyExchange.text!
            let value = Double(text)!
//            let result = "\(value * (1 / (data.rates[currencyOne]!)) * (data.rates[currencyTwo]!))"
//            secondCurrencyExchange.text = String(format:"%.2f", result)
            secondCurrencyExchange.text = "\(value * (1 / (data.rates[currencyOne]!)) * (data.rates[currencyTwo]!))"
        }
    }
//    extension ExchangeViewController: UITextFieldDelegate {
//        @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
//            eurosExchange.resignFirstResponder()
//            dollarsExchange.resignFirstResponder()
//        }
//    }


}
