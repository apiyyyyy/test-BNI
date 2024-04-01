//
//  ConfirmationViewController.swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 21/01/24.
//

import UIKit

class ConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func returnHomeAction(_ sender: UIButton) {
        if let homeVc = self.navigationController?.viewControllers.firstIndex(where: {$0 is HomeViewController}) {
            self.navigationController?.popToViewController(self.navigationController!.viewControllers[homeVc], animated: true)
        }
    }
}
