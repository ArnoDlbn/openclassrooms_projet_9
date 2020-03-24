//
//  ApiKeyExtractor.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 24/03/2020.
//  Copyright © 2020 Arnaud Dalbin. All rights reserved.
//

import Foundation

class ApiKeyExtractor {

    var apiKey: ApiKeys? {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else { return nil }
        guard let dataApi = try? PropertyListDecoder().decode(ApiKeys.self, from: data) else { return nil }
        return dataApi
    }
}

struct ApiKeys: Decodable {
    let apiExchange: String
    let apiTranslate: String
    let apiWeather: String
}
