//
//  Errors.swift
//  ZipCodesNearBy
//
//  Created by Gnana Thallaparthy on 9/19/21.
//

import Foundation

public struct ZipCodeError: Error {
    public var description = ""
    public var type: ErrorType?
    
    public enum ErrorType: Int {
        case noCorrectRequest
        case disabledAPI
        case noZipCode
        case limitUsage
        case InvalidURL
    }
    
    init(type: ErrorType) {
        self.type = type
        let errorInfo = getErrorInfo(type: type)
        self.description = errorInfo
    }
    
    func getErrorInfo(type: ErrorType) -> (String) {
        var desc = ""
        switch type {
        case .noCorrectRequest:
            desc = "The request format was not correct."
        case .disabledAPI:
            desc = "The API key was not found, was not activated, or has been disabled."
        case .noZipCode:
            desc = "A zip code you provided was not found."
        case .limitUsage:
            desc = "The usage limit for your application has been exceeded for the hour time period."
        case .InvalidURL:
            desc = "Invalid URl"
        }
        return desc
    }
}
