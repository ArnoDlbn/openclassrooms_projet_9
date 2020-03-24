//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 09/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

//func numberOfComponents(in pickerView: UIPickerView) -> Int {
//    return 1
//}
//func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    return chooseLanguageData.count
//}
//func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    return chooseLanguageData[row]
//}
//func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    if firstLanguage.state == .selected { firstLanguage.setTitle(chooseLanguageData[row], for: .normal)
//        firstLanguage.isSelected = false
//    }
//    if secondLanguage.state == .selected {
//    secondLanguage.setTitle(chooseLanguageData[row], for: .normal)
//        secondLanguage.isSelected = false
//    }
//    chooseLanguage.isHidden = true
//}


    @IBOutlet weak var firstLanguage: UIButton!
    @IBOutlet weak var secondLanguage: UIButton!
    @IBOutlet weak var firstLanguageText: UITextField!
    @IBOutlet weak var secondLanguageText: UITextField!
    @IBOutlet weak var chooseLanguage: UIPickerView!
    var chooseLanguageData: [String] = [String]()
    
    
    @IBAction func languageOne(_ sender: UIButton) {
        chooseLanguage.isHidden = false
        firstLanguage.isSelected = true
    }
    @IBAction func languageTwo(_ sender: UIButton) {
        chooseLanguage.isHidden = false
        secondLanguage.isSelected = true
    }
    @IBAction func translate(_ sender: Any) {
        TranslateService.getTranslation(text: firstLanguageText.text!) { (Translate, error) in
            self.updateView(data: Translate!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLanguage.setTitle("Français", for: .normal)
        secondLanguage.setTitle("Anglais", for: .normal)
        chooseLanguage.isHidden = true
//        self.chooseLanguage.delegate = self
//        self.chooseLanguage.dataSource = self
//        chooseLanguageData = ["English", "French", "German", "Spanish"]
    }
    
    func updateView(data: Translation) {
        secondLanguageText.text = data.data.translations[0].translatedText
    }

}
