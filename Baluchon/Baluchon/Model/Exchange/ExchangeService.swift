//
//  ExchangeView.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 08/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

class ExchangeService {
    
    static func getExchange(completionHandler: @escaping (ExchangeRate?, Error?) -> Void) {
        
        guard let apiKey = ApiKeyExtractor().apiKey else { return }
        
        let request = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey.apiExchange)")!
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) {(data, response, error) in DispatchQueue.main.async {
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
                let responseJSON = try JSONDecoder().decode(ExchangeRate.self, from: data)
                completionHandler(responseJSON, nil)
                print(responseJSON)
            } catch {
                completionHandler(nil, error)
                print(error)
            }
            }
        }
        task.resume()
        
    }

    static func convertFrom(label: String) -> String {
        switch label {
        case "Australian Dollar": return "AUD"
        case "Canadian Dollar": return "CAD"
        case "Swiss Franc": return "CHF"
        case "Euro": return "EUR"
        case "British Pound Sterling": return "GBP"
        case "Japanese Yen": return "JPY"
        case "United States Dollar": return "USD"
        default:
            break
        }
        return label
    }
}

