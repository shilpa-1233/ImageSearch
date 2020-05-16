//
//  ApiError.swift
//  oxfordCaps
//
//  Created by Ankit  Chaudhary on 26/03/19.
//  Copyright © 2019 Ankit  Chaudhary. All rights reserved.
//

import Foundation
enum ApiError: Error {
    case invalidUser            //Status code 401
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}
