//
//  ErrorCases.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 12/04/2020.
//  Copyright © 2020 Arnaud Dalbin. All rights reserved.
//

import Foundation

// enumeration to manage errors
enum ErrorCases: Swift.Error {
    case noData
    case wrongResponse(statusCode: Int?)
    case failure
    case errorDecode
}
