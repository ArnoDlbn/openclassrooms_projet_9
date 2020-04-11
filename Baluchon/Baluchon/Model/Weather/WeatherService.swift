//
//  Weather.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 08/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

class WeatherService {
    
    enum Error: Swift.Error {
        case noData
        case wrongResponse(statusCode: Int?)
    }
    
    var weatherSession = URLSession(configuration: .default)
    
    func getWeather(city: String, completionHandler: @escaping (CityWeather?, Swift.Error?) -> Void) {
        guard let apiKey = ApiKeyExtractor().apiKey else { return print("PAS DE KEY") }
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let request = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity!)&units=metric&appid=\(apiKey.apiWeather)")!
        
        let task = weatherSession.dataTask(with: request) {(data, rresponse, error) in DispatchQueue.main.async {
            guard error == nil else {
                completionHandler(nil, error)
                return print("PAS BIEN")
            }
            
            guard let response = rresponse as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, Error.wrongResponse(statusCode: (rresponse as? HTTPURLResponse)?.statusCode))
                return print("PAS BIEN 2")
            }
            
            guard let data = data else {
                completionHandler(nil, Error.noData)
            
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
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
}
