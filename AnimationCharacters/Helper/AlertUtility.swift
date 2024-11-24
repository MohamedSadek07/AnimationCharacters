//
//  AlertUtility.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import UIKit

class AlertUtility{
    class func showAlert(title: String, message: String, VC: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (alertAction) in
        })
        alertVC.addAction(ok)
        VC.present(alertVC, animated: true, completion: nil)
    }
}
