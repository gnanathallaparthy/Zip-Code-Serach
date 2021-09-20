//
//  ZipCodeSearchAPI.swift
//  ZipCodesNearBy
//
//  Created by Gnana Thallaparthy on 9/19/21.
//

import Foundation

let MAIN_URL = "https://www.zipcodeapi.com/rest/"
private let API_KEY = "BZBZXAhWPZm0QRpc0N6W9BS1DKDD8Gu4ySnq1UAqaBpze7HHHh85S9h1pOTBBrzq"


protocol ZipCodeSearcherApiHandlerProtocol {
    func searchZipCodes(zipCode: String, distance: String, onCompletion: @escaping ((Data?, URLResponse?, Error?) -> Void))
}

struct ZipCodeSearcherApiHandler: ZipCodeSearcherApiHandlerProtocol {
    let urlSession: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        urlSession = URLSession(configuration: configuration)
    }
    
    func searchZipCodes(zipCode: String, distance: String, onCompletion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let formattedUrl = MAIN_URL + API_KEY + "/radius.json/\(zipCode)/\(distance)/km"
        let url: URL? = URL(string: formattedUrl)
        guard let _ = url else {
            onCompletion(nil, nil, ZipCodeError(type: .InvalidURL))
            return
        }
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = {(data, response, error) in
            onCompletion(data,response, error)
        }
        let dataTask = urlSession.dataTask(with: url!, completionHandler: completionHandler)
        dataTask.resume()
    }
}
