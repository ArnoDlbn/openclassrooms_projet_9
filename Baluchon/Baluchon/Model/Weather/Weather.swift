//
//  Weather.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 11/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

struct CityWeather: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Cloud
}

struct Weather: Decodable {
    let main: String
}

struct Main: Decodable {
    let temp: Float
}

struct Wind: Decodable {
    let speed: Float
}

struct Cloud: Decodable {
    let all: Float
}
