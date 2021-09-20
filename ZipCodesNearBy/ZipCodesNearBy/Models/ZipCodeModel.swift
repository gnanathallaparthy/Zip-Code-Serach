//
//  ZipCodeModel.swift
//  ZipCodesNearBy
//
//  Created by Gnana Thallaparthy on 9/19/21.
//

import Foundation

protocol ZipCodeModelProtocol {
    var zip_code: String {get set}
    var distance: Double {get set}
    var city: String {get set}
    var state: String {get set}
}

struct ZipCodeModel: ZipCodeModelProtocol, Decodable {
    var zip_code: String
    var distance: Double
    var city: String
    var state: String
}

struct RawZipCodeResponseModel: Decodable {
    var zip_codes: Array<ZipCodeModel>
}
