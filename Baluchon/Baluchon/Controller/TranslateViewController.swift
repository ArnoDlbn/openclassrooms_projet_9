//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 09/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {


    // MARK: - Properties
    
    // stored data for pickerView
    var chooseLanguageData: [String] = ["English", "French", "German", "Spanish"]
    // instance of the TranslateService class
    let translate = TranslateService()

    // MARK: - Outlets
    
    @IBOutlet weak var firstLanguage: UIButton!
    @IBOutlet weak var secondLanguage: UIButton!
    @IBOutlet weak var firstLanguageText: UITextField!
    @IBOutlet weak var secondLanguageText: UITextField!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var update: UIButton!
    //    @IBOutlet weak var chooseLanguage: UIPickerView!
    
    // MARK: - Actions
    
    // choose first language
//    @IBAction func languageOne(_ sender: UIButton) {
//        chooseLanguage.isHidden = false
//        firstLanguage.isSelected = true
//    }
    // choose second language
//    @IBAction func languageTwo(_ sender: UIButton) {
//        chooseLanguage.isHidden = false
//        secondLanguage.isSelected = true
//    }
    // check if there is value and translate
    @IBAction func translate(_ sender: Any) {
//        guard firstLanguage.title(for: .normal) != nil, secondLanguage.title(for: .normal) != nil else {
//            // send an alert to enter a value to translate
//            alert(title: "Erreur", message: "Entrez une langue !")
//            return
//        }
        guard firstLanguageText.text != "" else {
            // send an alert to enter a value to convert
            alert(title: "Erreur", message: "Tapez un texte !")
            return
        }
        updatetranslation()
    }
    
    // MARK: - View Life cycle and set languages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateActivityIndicator.isHidden = true
        firstLanguage.setTitle("Français", for: .normal)
        secondLanguage.setTitle("Anglais", for: .normal)
//        chooseLanguage.isHidden = true
//        self.chooseLanguage.delegate = self
//        self.chooseLanguage.dataSource = self
    }
    
    // MARK: - Methods
    
    // get translation and display it
    func updatetranslation () {
        activityIndicator(activityIndicator: translateActivityIndicator, button: update, showActivityIndicator: true)
        translate.getTranslation(text: firstLanguageText.text!) { (Translate, error) in
            if error == nil {
                self.showTranslation(data: Translate!)
            } else {
                self.alert(title: "Erreur", message: "Veuillez vérifier les informations renseignées et votre connexion !")
            }
        }
        activityIndicator(activityIndicator: translateActivityIndicator, button: update, showActivityIndicator: false)
    }
    // display translation from first language to second
    func showTranslation(data: Translation) {
        secondLanguageText.text = data.data.translations[0].translatedText
    }
}

// MARK: - Extension for pickerView
    
//extension TranslateViewController : UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return chooseLanguageData.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return chooseLanguageData[row]
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if firstLanguage.state == .selected { firstLanguage.setTitle(chooseLanguageData[row], for: .normal)
//            firstLanguage.isSelected = false
//        }
//        if secondLanguage.state == .selected {
//        secondLanguage.setTitle(chooseLanguageData[row], for: .normal)
//            secondLanguage.isSelected = false
//        }
//        chooseLanguage.isHidden = true
//    }
    
    //MARK: - Extension to dismiss Keyboard

extension TranslateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstLanguageText.resignFirstResponder()
    }
}

