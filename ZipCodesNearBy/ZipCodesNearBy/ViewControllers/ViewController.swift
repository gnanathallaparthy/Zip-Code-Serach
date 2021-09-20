//
//  ViewController.swift
//  ZipCodesNearBy
//
//  Created by Gnana Thallaparthy on 9/19/21.
//

import UIKit


final class ViewController: UIViewController {
    
    @IBOutlet private var tfZipCode: UITextField!
    @IBOutlet private var tfDistance: UITextField!
    @IBOutlet private var tableView: UITableView!
    private var activityIndicator = UIActivityIndicatorView()
    
    var viewModel: ZipCodeSearcherViewModelProtocol = ZipCodeSearcherViewModel(apiHandler: ZipCodeSearcherApiHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        addActivityIndicator()
        activityIndicator.isHidden = true
        setupViewModel()
    }
    
    private func setupViewModel() {
        self.viewModel.reload = { [weak self]  in
            DispatchQueue.main.async {
                self?.tableView.isHidden = false
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        self.viewModel.errorInfo = { [weak self] error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.showAlertWarning(message: error.description)
            }
        }
    }
}

// TableView Delegete and Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.viewModel.getData()
        return data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.renderCell(tableView: tableView, indexPath: indexPath)
    }
    
    private func renderCell(tableView: UITableView,indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.ZipCodeCell)
        if(cell === nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: ReuseIdentifiers.ZipCodeCell)
        }
        if let zipCodeData = self.viewModel.getData(), indexPath.row < zipCodeData.count {
            let dataAtIndex = zipCodeData[indexPath.row]
            cell?.textLabel?.text = dataAtIndex.zip_code
        }
        return cell ?? UITableViewCell()
    }
}

// Button Actions
extension ViewController {
    @IBAction
    func onTapSearchButton(_ sender: UIButton) {
        viewModel.inputFiledsValidations(zipcode: tfZipCode.text, distance: tfDistance.text) { bool, message in
            if bool == true {
                tableView.isHidden = true
                showAlertWarning(message: message)
                return
            }
        }
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        if let zip = tfZipCode.text , let dis = tfDistance.text {
            self.viewModel.onSearchZipCodes(with: zip, distance: dis)
        }
    }
    
    private func showAlertWarning(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: TextConstants.alertTitle, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: TextConstants.alertButton, style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.color = .lightGray
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
    }
}


