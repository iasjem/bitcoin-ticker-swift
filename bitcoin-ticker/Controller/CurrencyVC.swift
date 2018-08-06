//
//  ViewController.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 30/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class CurrencyVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var loadingView: UIStackView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Initializers
    
    var service = CurrencyService.sharedInstance
    
    // MARK: View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewExchangeRate()
    }
    
    // MARK: Actions
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        viewExchangeRate()
    }
    
    // MARK: API functions
    
    func viewExchangeRate() {
        loadingData()
        service.retrieveData { (success) in
            if success {
                self.loadedData()
            } else {
                self.displayAlertDialog(title: "Error with internet connection", message: "Please try again after connecting to an available network")
            }
            self.tableView.reloadData()
        }
    }
    
    func loadingData() {
        service.clearData()
        self.tableView.isHidden = true
        self.loadingView.isHidden = false
        self.spinner.startAnimating()
    }
    
    func loadedData(){
        self.tableView.isHidden = false
        self.loadingView.isHidden = true
        self.spinner.stopAnimating()
    }
    
    // MARK: Helpers
    
    func displayAlertDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDelegate

extension CurrencyVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = service.currency[indexPath.row]
        service.getBTCData(code: currency.currencyCode, price: currency.marketPrice) { (success) in
            if success {
                self.displayAlertDialog(title: "BTC Value for \(currency.currencyCode)", message: "\(currency.currencySymbol) \(currency.marketPrice) = \(self.service.btcCurrency)")
            } else {
                self.displayAlertDialog(title: "Error with internet connection", message: "Please try again after connecting to an available network")
            }
        }
    }
}

// MARK: UITableViewDataSource

extension CurrencyVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.currency.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        let currency = service.currency[indexPath.row]
        cell.configureCell(code: currency.currencyCode, symbol: currency.currencySymbol, price: currency.marketPrice)
        return cell
    }
}

