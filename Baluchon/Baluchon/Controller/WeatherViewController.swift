//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 09/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

//func numberOfComponents(in pickerView: UIPickerView) -> Int {
//    return 1
//}
//func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    return chooseLocationData.count
//}
//func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    return chooseLocationData[row]
//}
//func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    if firstLocation.state == .selected { firstLocation.setTitle(chooseLocationData[row], for: .normal)
//        firstLocation.isSelected = false
//    }
//    if secondLocation.state == .selected {
//    secondLocation.setTitle(chooseLocationData[row], for: .normal)
//        secondLocation.isSelected = false
//    }
//    chooseLocation.isHidden = true
//}
    let weather = WeatherService()

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
    @IBOutlet weak var chooseLocation: UIPickerView!
    var locations = [String]()
    var chooseLocationData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLocation.setTitle("Paris", for: .normal)
        secondLocation.setTitle("New York", for: .normal)
        chooseLocation.isHidden = true
//        self.chooseLocation.delegate = self
//        self.chooseLocation.dataSource = self
//        chooseLocationData = ["My location", "Type location"]
    }
    
    @IBAction func locationOne(_ sender: UIButton) {
        chooseLocation.isHidden = false
        firstLocation.isSelected = true
    }
    
    @IBAction func locationTwo(_ sender: UIButton) {
        chooseLocation.isHidden = false
        secondLocation.isSelected = true
    }
    
    @IBAction func forecastWeather(_ sender: UIButton) {
        updateWeather()
    }
    
    private func updateWeather() {
        weather.getWeather(city: firstLocation.title(for: .normal)!, completionHandler: { (weather, error) in
            self.showInfoLocOne(data: weather!)
        })
        weather.getWeather(city: secondLocation.title(for: .normal)!, completionHandler: { (weather, error) in
            self.showInfoLocTwo(data: weather!)
        })
        
    }
    
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
