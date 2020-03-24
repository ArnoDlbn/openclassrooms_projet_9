//
//  Weather.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 08/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

class WeatherService {
    
    static var weatherSession = URLSession(configuration: .default)
    
    static func getWeather(city: String, completionHandler: @escaping (CityWeather?, Error?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let request = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity!)&units=metric")!
        
        let task = weatherSession.dataTask(with: request) {(data, response, error) in DispatchQueue.main.async {
            guard error == nil else {
                completionHandler(nil, error)
                return print("PAS BIEN")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, nil)
                return print("PAS BIEN 2")
            }
            
            guard let data = data else {
                return print("NO DATA")
            }
            
            do {
                let responseJSON = try JSONDecoder().decode(CityWeather.self, from: data)
                print(responseJSON)
                completionHandler(responseJSON, nil)
            } catch {
                completionHandler(nil, error)
                print(error)
            }
            }
        }
        task.resume()
    }
    
    init(weatherSession: URLSession) {
        WeatherService.self.weatherSession = weatherSession
    }
    
}
