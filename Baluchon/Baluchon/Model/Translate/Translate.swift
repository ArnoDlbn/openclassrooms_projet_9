//
//  Translate.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 11/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

// structures to manage data
struct Translation: Decodable {
    let data: Data
}

struct Data : Decodable {
    let translations : [Translations]
}

struct Translations: Decodable {
    let translatedText: String
}
