//
//  Extension .swift
//  TestProjectScanQr
//
//  Created by MOHAMMADB on 22/01/24.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
}

extension Double {
    func formatToIDR() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "IDR"
        numberFormatter.minimumFractionDigits = 0
        
        if let formattedString = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "Error formatting currency"
        }
    }
}
