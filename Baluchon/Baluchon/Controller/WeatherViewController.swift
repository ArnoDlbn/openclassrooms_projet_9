//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 09/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Properties
    
    // stored data for pickerView
//    var chooseLocationData: [String] = ["My location", "Choose location"]
    // store picked locations
//    var locations = [String]()
    // instance of the WeatherService class
    let weather = WeatherService()

    // MARK: - Outlets
    
    @IBOutlet weak var firstLocation: UIButton!
    @IBOutlet weak var secondLocation: UIButton!
    @IBOutlet weak var infoLocOne: UIStackView!
    @IBOutlet weak var infoLocTwo: UIStackView!
    @IBOutlet weak var weatherLocOne: UILabel!
    @IBOutlet weak var tempLocOne: UILabel!
    @IBOutlet weak var windLocOne: UILabel!
    @IBOutlet weak var weatherLocTwo: UILabel!
    @IBOutlet weak var tempLocTwo: UILabel!
    @IBOutlet weak var windLocTwo: UILabel!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forecast: UIButton!
    //    @IBOutlet weak var chooseLocation: UIPickerView!
    
    // MARK: - Actions
    
    // choose first location
//    @IBAction func locationOne(_ sender: UIButton) {
//        chooseLocation.isHidden = false
//        firstLocation.isSelected = true
//    }
    // choose second location
//    @IBAction func locationTwo(_ sender: UIButton) {
//        chooseLocation.isHidden = false
//        secondLocation.isSelected = true
//    }
    // check if there is value and forecast weather
    @IBAction func forecastWeather(_ sender: UIButton) {
//        guard firstLocation.title(for: .normal) != nil, secondLocation.title(for: .normal) != nil else {
//            // send an alert to enter a value to convert
//            alert(title: "Erreur", message: "Entrez une ville !")
//            return
//        }
        updateWeather()
    }
    
    // MARK: - View Life cycle and set locations

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherActivityIndicator.isHidden = true
        firstLocation.setTitle("Paris", for: .normal)
        secondLocation.setTitle("New York", for: .normal)
//        chooseLocation.isHidden = true
//        self.chooseLocation.delegate = self
//        self.chooseLocation.dataSource = self
    }
    
    // MARK: - Methods
    
    // get weather from the call and display it
    private func updateWeather() {
        activityIndicator(activityIndicator: weatherActivityIndicator, button: forecast, showActivityIndicator: true)
        weather.getWeather(city: firstLocation.title(for: .normal)!, completionHandler: { (weather, error) in
            if error == nil {
                self.showInfoLocOne(data: weather!)
            } else {
                self.alert(title: "Erreur", message: "Veuillez vérifier les informations renseignées et votre connexion !")
            }
        })
        weather.getWeather(city: secondLocation.title(for: .normal)!, completionHandler: { (weather, error) in
            if error == nil {
                self.showInfoLocTwo(data: weather!)
            } else {
                self.alert(title: "Erreur", message: "Veuillez vérifier les informations renseignées et votre connexion !")
            }
        })
        activityIndicator(activityIndicator: weatherActivityIndicator, button: forecast, showActivityIndicator: false)
    }
    // display informations for first and second location
    private func showInfoLocOne (data: CityWeather) {
        weatherLocOne.text = data.weather[0].main
        tempLocOne.text = "\(data.main.temp)" + "°C"
        windLocOne.text = "\(data.wind.speed)" + "km/h"
    }
    private func showInfoLocTwo (data: CityWeather) {
        weatherLocTwo.text = data.weather[0].main
        tempLocTwo.text = "\(data.main.temp)" + "°C"
        windLocTwo.text = "\(data.wind.speed)" + "km/h"
    }
}

// MARK: - Extension for pickerView
//
//extension ExchangeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
//    method to return the number's colum of the UIPickerView
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    method to return the number of lines in the UIPickerView
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return chooseLocationData.count
//    }
//    method to fill the UIPickerView with stored data
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return chooseLocationData[row]
//    }
//    method to returns the value corresponding to the UIPickerView
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if firstLocation.state == .selected { firstLocation.setTitle(chooseLocationData[row], for: .normal)
//            firstLocation.isSelected = false
//        }
//        if secondLocation.state == .selected {
//            secondLocation.setTitle(chooseLocationData[row], for: .normal)
//            secondLocation.isSelected = false
//        }
//        chooseLocation.isHidden = true
//}
// MARK: - Extension to dismiss Keyboard
//
//extension WeatherViewController: UITextFieldDelegate {
//    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
//        firstLocation.resignFirstResponder()
//        secondLocation.resignFirstResponder()
//    }
//}
