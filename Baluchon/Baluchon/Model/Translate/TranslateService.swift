//
//  TranslateView.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 08/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

class TranslateService {
    
    static let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?")!
    static var translateSession = URLSession(configuration: .default)
    
    static func getTranslation(text: String, completionHandler: @escaping (Translation?, Error?) -> Void) {
        guard let request = createTranslateRequest(text: text) else { return }

        let task = translateSession.dataTask(with: request) {(data, response, error) in DispatchQueue.main.async {
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
                    let responseJSON = try JSONDecoder().decode(Translation.self, from: data)
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

    static func createTranslateRequest(text: String) -> URLRequest? {
        guard let apiKey = ApiKeyExtractor().apiKey else { return nil }
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        let q = text
        let body = "q=\(q)" + "&source=fr" + "&target=en" + "&format=text" + "&key=\(apiKey.apiTranslate)"
        request.httpBody = body.data(using: .utf8)

        return request
    }
    
    init(translateSession: URLSession) {
        TranslateService.self.translateSession = translateSession
    }
    
}
