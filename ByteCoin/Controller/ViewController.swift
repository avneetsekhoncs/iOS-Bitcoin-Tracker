//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

//Important to adpot CoinManagerDelegate Protocol
class ViewController: UIViewController {
    
    var coinManager = CoinManager() //var because it allows the properties to change

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var bitcoinCurrency: UILabel!
    @IBOutlet weak var bitcoinPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self //Set the coinManager's delegate to current class to receive notifications from delagate methods that are called
        bitcoinPicker.dataSource = self //ViewController is the datasource for the picker
        bitcoinPicker.delegate = self
        
    }
}


//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String) {
        
        /*
         DispatchQueue gets a hold of the main thread. Data is coming from a networking     completion handler which usually runs in the background and can take a few seconds to minutes to complete. Therefore UI updates need to be done on the main thread.
         */
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.bitcoinCurrency.text = currency
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Number of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows per column based on array size
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //Row titles from the array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //Sends the selected currency
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}
