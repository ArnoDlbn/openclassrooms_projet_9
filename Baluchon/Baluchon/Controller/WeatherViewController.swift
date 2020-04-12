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
    
    // MARK: - Actions
    
    // check if there is value and forecast weather
    @IBAction func forecastWeather(_ sender: UIButton) {
        guard firstLocation.title(for: .normal) != nil, secondLocation.title(for: .normal) != nil else {
            // send an alert to enter a value to convert
            alert(title: "Erreur", message: "Entrez une ville !")
            return
        }
        updateWeather()
    }
    
    // MARK: - View Life cycle and set locations

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherActivityIndicator.isHidden = true
        firstLocation.setTitle("Paris", for: .normal)
        secondLocation.setTitle("New York", for: .normal)
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
