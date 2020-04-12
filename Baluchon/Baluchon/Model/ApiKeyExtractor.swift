//
//  ApiKeyExtractor.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 24/03/2020.
//  Copyright © 2020 Arnaud Dalbin. All rights reserved.
//

import Foundation

class ApiKeyExtractor {

    // get API Keys from ApiKeys.plist
    var apiKey: ApiKeys? {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else { return nil }
        guard let dataApi = try? PropertyListDecoder().decode(ApiKeys.self, from: data) else { return nil }
        return dataApi
    }
}

// structure to manage API Keys
struct ApiKeys: Decodable {
    let apiExchange: String
    let apiTranslate: String
    let apiWeather: String
}
