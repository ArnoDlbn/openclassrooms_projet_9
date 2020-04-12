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
    
    // instance of the TranslateService class
    let translate = TranslateService()

    // MARK: - Outlets
    
    @IBOutlet weak var firstLanguage: UIButton!
    @IBOutlet weak var secondLanguage: UIButton!
    @IBOutlet weak var firstLanguageText: UITextField!
    @IBOutlet weak var secondLanguageText: UITextField!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var update: UIButton!
    
    // MARK: - Actions
    
    // check if there is value and translate
    @IBAction func translate(_ sender: Any) {
        guard firstLanguage.title(for: .normal) != nil, secondLanguage.title(for: .normal) != nil else {
            // send an alert to enter a value to translate
            alert(title: "Erreur", message: "Entrez une langue !")
            return
        }
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
    
    //MARK: - Extension to dismiss Keyboard

extension TranslateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstLanguageText.resignFirstResponder()
    }
}

