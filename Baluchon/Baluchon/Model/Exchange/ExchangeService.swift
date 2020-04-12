//
//  ExchangeView.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 08/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

class ExchangeService {
    
    // MARK: - Properties
    
    // URLSession
    var exchangeSession = URLSession(configuration: .default)
    // URLSessionDataTask
    var task: URLSessionDataTask?
    // initialize URLSession
    init(exchangeSession: URLSession = URLSession(configuration: .default)) {
        self.exchangeSession = exchangeSession
    }
    
    // MARK: - Methods
    
    // send a request to Fixer API and return this response
    func getExchange(completionHandler: @escaping (ExchangeRate?, Error?) -> Void) {
        // get API Key
        guard let apiKey = ApiKeyExtractor().apiKey else { return }
        // call
        guard let request = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey.apiExchange)") else { return }
        task?.cancel()
        task = exchangeSession.dataTask(with: request) {(data, rresponse, error) in DispatchQueue.main.async {
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
                let responseJSON = try JSONDecoder().decode(ExchangeRate.self, from: data)
                completionHandler(responseJSON, nil)
            } catch {
                completionHandler(nil, ErrorCases.errorDecode)
            }
            }
        }
        task?.resume()
    }

    // switch currency name to his international symbol
    func convertFrom(label: String) -> String {
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
