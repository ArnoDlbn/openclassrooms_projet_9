//
//  ExchangeViewController.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 09/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    //    MARK: - Properties
    
    //    stored data for pickerView
    var chooseCurrencyData : [String] = ["Australian Dollar", "Canadian Dollar", "Swiss Franc", "Euro", "British Pound Sterling", "Japanese Yen", "United States Dollar"]
    // instance of the ExchangeService class
    let exchange = ExchangeService()
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstCurrency: UIButton!
    @IBOutlet weak var secondCurrency: UIButton!
    @IBOutlet weak var firstCurrencyExchange: UITextField!
    @IBOutlet weak var secondCurrencyExchange: UITextField!
    @IBOutlet weak var chooseCurrency: UIPickerView!
    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var exchangeActivityIndicator: UIActivityIndicatorView!
    
    //    MARK: - Actions
    
    // choose first currency
    @IBAction func currencyOne(_ sender: UIButton) {
        chooseCurrency.isHidden = false
        firstCurrency.isSelected = true
    }
    // choose second currency
    @IBAction func currencyTwo(_ sender: UIButton) {
        chooseCurrency.isHidden = false
        secondCurrency.isSelected = true
    }
    // check if there is value and convert
    @IBAction func exchange(_ sender: UIButton) {
        guard firstCurrency.title(for: .normal) != "First Currency", secondCurrency.title(for: .normal) != "Second Currency" else {
            // send an alert to choose a currency
            alert(title: "Erreur", message: "Choisissez une devise !")
            return
        }
        guard firstCurrencyExchange.text != "", firstCurrencyExchange.text != "," else {
            // send an alert to enter a value to convert
            alert(title: "Erreur", message: "Entrez un montant !")
            return
        }
        convert()
    }
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeActivityIndicator.isHidden = true
        chooseCurrency.isHidden = true
        self.chooseCurrency.delegate = self
        self.chooseCurrency.dataSource = self
    }
    
    // MARK: - Methods

    // get rate from the call and convert
    func convert () {
        activityIndicator(activityIndicator: exchangeActivityIndicator, button: update, showActivityIndicator: true)
        exchange.getExchange(completionHandler: { (rate, error) in
            if error == nil {
                self.calculate(data: rate!)
            } else {
                self.alert(title: "Erreur", message: "Veuillez vérifier les informations renseignées et votre connexion !")
            }
        })
        activityIndicator(activityIndicator: exchangeActivityIndicator, button: update, showActivityIndicator: false)
    }
    // convert first currency to second and display it
    func calculate (data: ExchangeRate) {
        // change selected currency to international symbol
        let currencyOne = exchange.convertFrom(label: firstCurrency.title(for: .normal)!)
        let currencyTwo = exchange.convertFrom(label: secondCurrency.title(for: .normal)!)
        // convert
        if currencyOne == data.base || currencyTwo == data.base {
            if currencyOne == data.base {
                guard let text = firstCurrencyExchange.text, let value = Double(text) else { return }
                //                let result = "\(value * data.rates[currencyTwo]!)"
                //                secondCurrencyExchange.text = String(format:"%.2f", result)
                secondCurrencyExchange.text = "\(value * data.rates[currencyTwo]!)"
            } else {
                guard let text = firstCurrencyExchange.text, let value = Double(text) else { return }
                //                let result = "\(value * (1 / (data.rates[currencyOne]!)))"
                //                secondCurrencyExchange.text = String(format:"%.2f", result)
                secondCurrencyExchange.text = "\(value * (1 / (data.rates[currencyOne]!)))"
            }
        } else {
            guard let text = firstCurrencyExchange.text, let value = Double(text) else { return }
//            let result = "\(value * (1 / (data.rates[currencyOne]!)) * (data.rates[currencyTwo]!))"
//            secondCurrencyExchange.text = String(format:"%.2f", result)
            secondCurrencyExchange.text = "\(value * (1 / (data.rates[currencyOne]!)) * (data.rates[currencyTwo]!))"
        }
    }
}

// MARK: - Extension for pickerView

extension ExchangeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    // method to return the number's colum of the UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // method to return the number of lines in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chooseCurrencyData.count
    }
    // method to fill the UIPickerView with stored data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return chooseCurrencyData[row]
    }
    // method to returns the value corresponding to the UIPickerView
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
}
// MARK: - Extension to dismiss Keyboard

extension ExchangeViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstCurrencyExchange.resignFirstResponder()
    }
}



