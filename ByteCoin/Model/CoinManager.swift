//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "B774914E-1175-4916-83C1-B499CE804D4D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    //Perform networking to get live data
    func performRequest(with urlString: String) {
        //Create a URL
        if let url = URL(string: urlString){
            //Create a URLSession
            let session = URLSession(configuration: .default)
            //Give session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                
                if let readData = data {
                    let coinPrice = self.parseJSON(readData)
                    print(coinPrice)
                }
            }
            
            //Start the task
            task.resume()
        }
    }
    
    //Parse the data
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            
            return lastPrice
        } catch {
            print(error)
            return nil
        }
    }
}
