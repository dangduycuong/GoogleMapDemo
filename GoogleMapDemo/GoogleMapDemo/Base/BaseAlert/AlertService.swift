//
//  AlertService.swift
//  GoogleMapDemo
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import UIKit

class AlertService {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    func showAlertWith(type: AlertType, message: String, completion: @escaping () -> Void) -> CustomAlertVC {
        
        let alertVC = CustomAlertVC(nibName: "CustomAlertVC", bundle: nil)
        
        alertVC.alertType = type
        alertVC.messageContent = message
        alertVC.buttonAction = completion
        
        return alertVC
    }
    
    func showAlertWithConfirm(type: AlertType, message: String, completionClose: @escaping() -> Void,  completionOK: @escaping() -> Void) -> AlertConfirmActionVC {
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertConfirmActionVC") as! AlertConfirmActionVC
        alertVC.alertType = type
        alertVC.messageContent = message
        alertVC.cancelAction = completionClose
        alertVC.okAction = completionOK
        
        return alertVC
    }
    
    func showAlert(type: AlertType, message: String) -> CustomAlertVC {
        //        let alertVC = CustomAlertVC(nibName: "CustomAlertVC", bundle: nil)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "CustomAlertVC") as! CustomAlertVC
        alertVC.alertType = type
        alertVC.messageContent = message
        
        return alertVC
    }
    
    //cuongdd
    //    func showAlertConfirm(type: AlertType, message: String,  cancel: @escaping () -> Void, ok: @escaping () -> Void) -> NimsCustomAlertVC {
    //
    //        let alertVC = NimsCustomAlertVC(nibName: "NimsCustomAlertVC", bundle: nil)
    //
    //        alertVC.alertType = type
    //        alertVC.messageContent = message
    //        alertVC.cancelAction = cancel
    //        alertVC.okAction = ok
    //
    //        return alertVC
    //    }
    //
    //    func showAlertWithAction(type: AlertType, message: String, ok: @escaping () -> Void) -> NimsAlertWithActionVC {
    //
    //        let alertVC = NimsAlertWithActionVC(nibName: "NimsAlertWithActionVC", bundle: nil)
    //        alertVC.alertType = type
    //        alertVC.messageContent = message
    //        alertVC.okAction = ok
    //
    //        return alertVC
    //    }
}
