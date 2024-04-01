//
//  TransactionViewController.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 21/01/24.
//

import UIKit

class TransactionViewController: UIViewController {
    
    
    @IBOutlet weak var merchantLabel: UILabel!
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let viewModel = TransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        merchantLabel.text = viewModel.qrData.merchantName
        nominalLabel.text = setBalance()
        confirmButton.setTitle("Confirm Payment", for: .normal)
        navigationItem.backBarButtonItem?.isHidden = true
        loadingProcess(loading: false)
    }
    
    func setBalance() -> String{
        let amount = viewModel.qrData.nominalTransaction
        let formatter = amount.formatted(.currency(code: "IDR"))
        return "\(formatter)"
    }
    
    func loadingProcess(loading: Bool) {
        if loading == true{
            activityIndicator.isHidden = false
            confirmButton.titleLabel?.text = ""
            confirmButton.isEnabled = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            confirmButton.titleLabel?.text = "Confirm Payment"
            confirmButton.isEnabled = true
            activityIndicator.stopAnimating()
        }
    }
    
    
    @IBAction func confirmPaymentAction(_ sender: UIButton) {
        loadingProcess(loading: true)
        
        viewModel.confirmTransaction(amount: viewModel.qrData.nominalTransaction, merchant: viewModel.qrData.merchantName, date: Date(), completion: {  result in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
                if result == true {
                    if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ConfirmationViewController") as? ConfirmationViewController {
                        destinationVC.vm.merchantString = viewModel.qrData.merchantName
                        destinationVC.vm.nominalString = setBalance()
                        navigationController?.pushViewController(destinationVC, animated: true)
                        return
                    }
                    loadingProcess(loading: false)
                }else {
                    let alert = UIAlertController(title: "APP_NAME", message: "Saldo anda kurang cukup", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        })
    }
}
