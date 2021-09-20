//
//  ZipCodeSearcherViewModel.swift
//  ZipCodesNearBy
//
//  Created by Gnana Thallaparthy on 9/19/21.
//

import Foundation

protocol ZipCodeSearcherViewModelProtocol {
    
    init(apiHandler: ZipCodeSearcherApiHandlerProtocol)
    var reload: (() -> Void)? {get set}
    var errorInfo: ((ZipCodeError) -> Void)? {get set}
    func onSearchZipCodes(with zipCode: String, distance: String)
    func getData() -> Array<ZipCodeModel>?
    func inputFiledsValidations(zipcode: String?, distance: String?, completionHandler: (_ success: Bool, _ message: String) -> Void)
}

class ZipCodeSearcherViewModel: ZipCodeSearcherViewModelProtocol {
    
    private let apiHandler: ZipCodeSearcherApiHandlerProtocol?
    private var data: Array<ZipCodeModel>?
    var reload:(() -> Void)?
    var errorInfo: ((ZipCodeError) -> Void)?
    typealias CompletionHandler = (_ success: Bool, _ message: String) -> Void
    
    required init(apiHandler: ZipCodeSearcherApiHandlerProtocol) {
        self.apiHandler = apiHandler
    }
    
    func onSearchZipCodes(with zipCode: String, distance: String) {
        let completionHandler: ((Data?, URLResponse?, Error?) -> Void) = {[weak self](data, response, error) in
            let isResponseSuccessed = response?.checkIfResponseSuccessed()
            guard error == nil && isResponseSuccessed == nil && data != nil else {
                self?.errorInfo?(isResponseSuccessed!)
                return
            }
            let zipCodes = try? JSONDecoder().decode(RawZipCodeResponseModel.self, from: data!)
            self?.data = zipCodes?.zip_codes.filter({item in
                return item.zip_code != zipCode
            })
            self?.reload?()
        }
        self.apiHandler?.searchZipCodes(zipCode: zipCode, distance: distance, onCompletion: completionHandler)
    }
    
    func getData() -> Array<ZipCodeModel>? {
        return self.data
    }
    
    func inputFiledsValidations(zipcode: String?, distance: String?, completionHandler: CompletionHandler)  {
        guard let inputZipCode = zipcode, inputZipCode.count > 0 else {
            completionHandler(true, TextConstants.enterZipError)
            return
        }
        
        guard let inputDistance = distance, inputDistance.count > 0 else {
            completionHandler(true, TextConstants.enterDistance)
            return
        }
        
        guard inputZipCode.count == Constants.ZIP_CODE_LENGTH else {
            completionHandler(true, "Minimun Zip code length is \(Constants.ZIP_CODE_LENGTH)")
            return
        }
        
        guard Constants.NUMBER_RANGE.contains(Int(inputDistance)!) else {
            completionHandler(true, "Please enter distance between \(Constants.DISTANCE_MIN_LENGTH) - \(Constants.DISTANCE_MAX_LENGTH)")
            return
        }
        completionHandler(false, "")
    }
}
