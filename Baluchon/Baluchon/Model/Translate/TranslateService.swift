//
//  TranslateView.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 08/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

class TranslateService {
    
    // MARK: - Properties
    
    // URLSession
    var translateSession = URLSession(configuration: .default)
    // URLSessionDataTask
    var task: URLSessionDataTask?
    // initialize URLSession
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // MARK: - Methods
    
    // send a request to Google Translate API and return response
    func getTranslation(text: String, completionHandler: @escaping (Translation?, ErrorCases?) -> Void) {
        // call
        guard let request = createTranslateRequest(text: text) else { return }
        task?.cancel()
        task = translateSession.dataTask(with: request) {(data, rresponse, error) in DispatchQueue.main.async {
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
                let responseJSON = try JSONDecoder().decode(Translation.self, from: data)
                completionHandler(responseJSON, nil)
            } catch {
                completionHandler(nil, ErrorCases.errorDecode)
            }
            }
        }
        task?.resume()
    }

    // create a request with a body
    func createTranslateRequest(text: String) -> URLRequest? {
        // get API Key
        guard let apiKey = ApiKeyExtractor().apiKey else { return nil }
        // get request
        guard let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?") else { return nil }
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        // stock text to translate
        let q = text
        // stock body with text, source language, target language and API Key
        let body = "q=\(q)" + "&source=fr" + "&target=en" + "&format=text" + "&key=\(apiKey.apiTranslate)"
        request.httpBody = body.data(using: .utf8)

        return request
    }
}
