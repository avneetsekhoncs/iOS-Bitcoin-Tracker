//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

//Important to adpot CoinManagerDelegate Protocol
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    var coinManager = CoinManager() //var because it allows the properties to change

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var bitcoinCurrency: UILabel!
    @IBOutlet weak var bitcoinPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self //Set the coinManager's delegate as current class to receive notification from delagate methods that are called
        bitcoinPicker.dataSource = self //ViewController is the datasource for the picker
        bitcoinPicker.delegate = self
        
    }
    
    func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String) {
        DispatchQueue.main.async {      //Dispatch.. gets a hold of the main thread
            self.bitcoinLabel.text = price
            self.bitcoinCurrency.text = currency
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1    //Number of columns in picker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count  //Number of rows per column
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}
