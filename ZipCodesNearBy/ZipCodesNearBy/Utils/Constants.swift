//
//  Constants.swift
//  ZipCodesNearBy
//
//  Created by Gnana Thallaparthy on 9/19/21.
//

import Foundation

struct Errors {
    public static var INVALID_URL = "Invalid URL"
}

struct ReuseIdentifiers {
    public static var  ZipCodeCell = "ZipCodeCell"
}

struct Constants {
    static let ZIP_CODE_LENGTH = 5
    static let DISTANCE_MIN_LENGTH = 1
    static let DISTANCE_MAX_LENGTH = 804
    static let NUMBER_RANGE = DISTANCE_MIN_LENGTH...DISTANCE_MAX_LENGTH
}

struct TextConstants {
    static let alertTitle = "Alert!"
    static let alertButton = "Ok"
    static let enterZipError = "Please enter zipcode"
    static let enterDistance = "Please enter distance"
}
