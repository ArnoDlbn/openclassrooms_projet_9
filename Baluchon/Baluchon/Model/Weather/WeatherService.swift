//
//  Weather.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 08/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

class WeatherService {
    
    // MARK: - Properties
    
    // URLSession
    var weatherSession = URLSession(configuration: .default)
    // URLSessionDataTask
    var task: URLSessionDataTask?
    // initialize URLSession
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    // MARK: - Methods
    
    // send a request to OpenWeatherMap API and return this response
    func getWeather(city: String, completionHandler: @escaping (CityWeather?, Swift.Error?) -> Void) {
        // get API Key
        guard let apiKey = ApiKeyExtractor().apiKey else { return }
        // get city chose by user
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        // call
        guard let request = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&units=metric&appid=\(apiKey.apiWeather)") else { return }
        task = weatherSession.dataTask(with: request) {(data, rresponse, error) in DispatchQueue.main.async {
            // check error
            guard error == nil else {
                completionHandler(nil, ErrorCases.failure)
                return
            }
            // check status response
            guard let response = rresponse as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, ErrorCases.wrongResponse(statusCode: (rresponse as? HTTPURLResponse)?.statusCode))
                return
            }
            // check data
            guard let data = data else {
                completionHandler(nil, ErrorCases.noData)
                return
            }
            // check response JSON
            do {
                let responseJSON = try JSONDecoder().decode(CityWeather.self, from: data)
                completionHandler(responseJSON, nil)
            } catch {
                completionHandler(nil, ErrorCases.errorDecode)
            }
            }
        }
        task?.resume()
    }
}
