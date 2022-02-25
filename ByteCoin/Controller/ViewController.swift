//
//  ViewController.swift
//  ByteCoin
//
//  Created by Евгений Башун on 13.02.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    var coinManager: CoinManagerDescription = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     //   print(row)
        let currency = coinManager.currencyArray[row]
        if row != 0 {
            coinManager.fetchExchangeData(from: currency) { [weak self] coinModel in
                DispatchQueue.main.async {
                    self?.currencyLabel.text = currency
                    self?.exchangeRateLabel.text = coinModel.rateString
                }
            }
        }
    }
    
}

