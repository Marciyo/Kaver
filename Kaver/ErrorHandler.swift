//
//  ErrorHandler.swift
//
//  Created by Maciej Matuszewski on 13.09.2016.
//  Copyright © 2016 Codeaddict. All rights reserved.
//

import Foundation
import UIKit

class ErrorHandler {
    static func handleError(code: Int) -> String {
        "Handle error with code: \(code) 😡".log()
        switch code {
        case 404: return "No user exist!".localized
        default:
            return "Something went wrong! Please try again.".localized
        }
    }
}

