//
//  AlertConfirmActionVC.swift
//  GoogleMapDemo
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import UIKit

class AlertConfirmActionVC: BaseAlertVC {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var alertType: AlertType?
    var messageContent = String()
    
    var cancelAction: (() -> Void)?
    var okAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setShadowView(view: contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupAlertView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setShadowView(view: UIView) {
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
    }
    
    func setupAlertView() {
        closeButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 17)
        okButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 17)
        
        self.titleLabel.font = UIFont(name: "Roboto-Regular", size: 17)
        self.messageLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        self.messageLabel.textColor = UIColor.darkGray
        self.closeButton.setTitle("Close", for: .normal)
        //        self.setupMessageContentText(string: messageContent)
        messageLabel.attributedText = setupMessageContentText(string: messageContent)
        //        messageLabel.text = messageContent
        
        if let type = alertType {
            switch type {
            case .Warning:
                //                self.titleLabel.text = "Warning"
                //                self.titleLabel.textColor = UIColor.init(named: "#FBC02D")
                //                self.imvIcon.image = UIImage(named: "ic_notice_orange")
                //                self.titleView.backgroundColor = UIColor.init(named: "#FFF9C4")
                //                self.closeButton.setTitleColor(UIColor.init(named: "#FBC02D"), for: .normal)
                
                self.titleLabel.text = "Warning"
                self.titleLabel.textColor = .colorWithHexString("#FBC02D")
                //                self.imageViewIcon.image = UIImage(named: "ic_notice_orange")
                imageViewIcon.image = #imageLiteral(resourceName: "icons8-error")
                self.titleLabel.backgroundColor = .colorWithHexString("#FFF9C4")
                self.closeButton.setTitleColor(.colorWithHexString("#FBC02D"), for: .normal)
                okButton.setTitleColor(.colorWithHexString("#FBC02D"), for: .normal)
                break
            case .Notice:
                self.titleLabel.text = "Thông báo"
                self.titleLabel.textColor = .colorWithHexString("#039BE5")
                //                self.imvIcon.image = UIImage(named: "ic_notice_blue")
                imageViewIcon.image = #imageLiteral(resourceName: "icons8-appointment_reminders")
                self.titleLabel.backgroundColor = .colorWithHexString("#B3E5FC")
                titleLabel.backgroundColor = #colorLiteral(red: 0.5589047074, green: 0.8262864947, blue: 0.9352757335, alpha: 1)
                self.closeButton.setTitleColor(.colorWithHexString("#039BE5"), for: .normal)
                okButton.setTitleColor(.colorWithHexString("#039BE5"), for: .normal)
                break
            case .Error:
                self.titleLabel.text = "Error"
                //                self.titleLabel.textColor = UIColor.init(named: "#EF5350")
                titleLabel.textColor = .colorWithHexString("#EF5350")
                //                self.imageViewIcon.image = UIImage(named: "ic_notice_red")
                imageViewIcon.image = #imageLiteral(resourceName: "icons8-error-1")
                
                titleLabel.backgroundColor = #colorLiteral(red: 1, green: 0.8039215686, blue: 0.8235294118, alpha: 1)
                
                self.closeButton.setTitleColor(UIColor.colorWithHexString("#EF5350"), for: .normal)
                okButton.setTitleColor(UIColor.colorWithHexString("#EF5350"), for: .normal)
                break
            }
        } else {return}
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: false, completion: cancelAction)
    }
    
    @IBAction func didTapOK(_ sender: Any) {
        dismiss(animated: false, completion: okAction)
    }
}

extension AlertConfirmActionVC {
    
    func setupMessageContentText(string: String) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        style.alignment = .left
        
        let attributes : [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),
             NSAttributedString.Key.foregroundColor : UIColor.black,
             NSAttributedString.Key.paragraphStyle : style]
        
        let attributeString = NSAttributedString(string: string, attributes: attributes)
        self.messageLabel.attributedText = attributeString
    }
}


class BaseAlertVC: UIViewController {
    func setupMessageContentText(string: String) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        style.alignment = .left
        
        let attributes : [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),
             NSAttributedString.Key.foregroundColor : UIColor.black,
             NSAttributedString.Key.paragraphStyle : style]
        
        let attributeString = NSAttributedString(string: string, attributes: attributes)
        return attributeString
        //        self.messageLabel.attributedText = attributeString
    }
}
