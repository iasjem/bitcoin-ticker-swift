//
//  ViewController.swift
//  bitcoin-ticker
//
//  Created by Jemimah Beryl M. Sai on 30/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class CurrencyVC: UIViewController {
    
    @IBOutlet weak var loadingView: UIStackView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var service = CurrencyService.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewExchangeRate()
    }
    
    
    func viewExchangeRate() {
        service.retrieveData { (success) in
            if success {
            self.loadedData()
            } else {
            self.loadingData()
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
}

extension CurrencyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

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

