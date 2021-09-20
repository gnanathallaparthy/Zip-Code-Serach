//
//  URLResppnse.swift
//  ZipCodesNearBy
//
//  Created by Gnana Thallaparthy on 9/19/21.
//
/*
 400    The request format was not correct.
 401    The API key was not found, was not activated, or has been disabled.
 404    A zip code you provided was not found.
 429
 */
import Foundation
extension URLResponse {
    func checkIfResponseSuccessed() -> ZipCodeError? {
        let httpResponse = self as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        if statusCode >= 200 && statusCode <= 299 {
            return nil
        } else if statusCode == 400 {
            return ZipCodeError(type: .noCorrectRequest)
        } else if statusCode == 401 {
            return ZipCodeError(type: .disabledAPI)
        } else if statusCode == 404 {
            return ZipCodeError(type: .noZipCode)
        } else if statusCode == 429 {
            return ZipCodeError(type: .limitUsage)
        }
        return ZipCodeError(type:.disabledAPI)
    }
}
