//
//  ZipCodeSearcherViewModelTests.swift
//  ZipCodesNearByTests
//
//  Created by Gnana Thallaparthy on 9/20/21.
//

import XCTest
@testable import ZipCodesNearBy

class ZipCodeSearcherViewModelTests: XCTestCase {
    var viewModel: ZipCodeSearcherViewModel?
    
    func test_validateInputFileds() {
        viewModel?.inputFiledsValidations(zipcode: "20228", distance: "22") { ( _ , _ ) in
        }
    }

    func test_webApiTest() {
        viewModel?.onSearchZipCodes(with: "20228", distance: "33")
    }
    
}
