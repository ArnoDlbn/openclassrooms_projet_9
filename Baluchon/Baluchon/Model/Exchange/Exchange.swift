//
//  Exchange.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 11/12/2019.
//  Copyright © 2019 Arnaud Dalbin. All rights reserved.
//

import Foundation

// structure to manage data
struct ExchangeRate: Decodable {
    let base: String
    let rates: [String: Double]
}
