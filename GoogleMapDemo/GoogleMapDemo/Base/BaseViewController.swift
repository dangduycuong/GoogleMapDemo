//
//  BaseViewController.swift
//  GoogleMapDemo
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//


import UIKit
//import KVLoading
//import ReachabilitySwift
enum ContentState {
    case hasContent
    case loading
    case empty
    case error
    case nothing
}

class BaseViewController: UIViewController {
    
    let alertService = AlertService()
    
    lazy var isLoadConfig = false
    private var enableHideKeyBoardWhenTouchInScreen: Bool = true
    var enableNotification = true
    var isLeftMenu = false
    var isEnableHideKeyBoardWhenTouchInScreen: Bool {
        get {
            return self.enableHideKeyBoardWhenTouchInScreen ? true : false
        }
        
        set {
            self.enableHideKeyBoardWhenTouchInScreen = newValue
            if self.enableHideKeyBoardWhenTouchInScreen {
                let touchOnScreen = UITapGestureRecognizer(target: self, action: #selector(self.touchOnScreen))
                touchOnScreen.delegate = self
                touchOnScreen.cancelsTouchesInView = false
                view.addGestureRecognizer(touchOnScreen)
            }
        }
    }
    
    var isEnabledLeftPanGesture: Bool = true
    
    lazy var masterView: UIView = {
        if let masterView = self.navigationController?.view {
            return masterView
        } else {
            return self.view
        }
    }()
    
    lazy var isLoading: Bool = false
    
    //    lazy var loading: LoadingView = {
    //        return LoadingView.loadFromNib()
    //    }()
    //
    //    lazy var reachability: Reachability = {
    //        let reachability = Reachability()
    //        return reachability!
    //    }()
    
    var selectedRightMenu:Bool = false
    //    {
    //        didSet {
    //            if selectedRightMenu {
    //                self.view.addSubview(rightMenuView)
    //            } else {
    //                rightMenuView.removeFromSuperview()
    //            }
    //        }
    //    }
    
    //    lazy var rightMenuView: UIView = {
    //        let rightMenuView: RightMenuView = RightMenuView.loadFromNib()
    //        rightMenuView.delegate = self
    //        let frame = CGRect(x: UIScreen.main.bounds.width - 165, y: 0, width: 165, height: 106)
    //        rightMenuView.frame = frame
    //        return rightMenuView
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isEnableHideKeyBoardWhenTouchInScreen = true
        self.setUpHiddenTabbar()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = .blue
        enableHideKeyBoardWhenTouchInScreen = true
        
        //        registerForBackgroundNotifications()
    }
    
    func setUpHiddenTabbar(){
        if let tabBarVC = self.tabBarController, !tabBarVC.tabBar.isHidden {
            tabBarVC.tabBar.isHidden = true
        }
    }
    
    func showTabbar(){
        if let tabBarVC = self.tabBarController, tabBarVC.tabBar.isHidden {
            tabBarVC.tabBar.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(!self.isLoadConfig)
        {
            configuration()
        }
        //        if enableNotification {
        //            addBroadcastNews()
        //        } else {
        //            hidenBroadcastLabel()
        //        }
        //        if let slideMenuController = self.slideMenuController() {
        //            slideMenuController.leftPanGesture?.isEnabled = isEnabledLeftPanGesture
        //        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.touchOnScreen()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        //        destroyForBackgroundNotifications()
    }
}

extension BaseViewController {
    
    // MARK: - Actions
    @objc func touchOnScreen() {
        view.endEditing(true)
    }
    
    @objc func reloadData() {
        
    }
    
    @objc func configuration() {
        
    }
    
    //    @objc func continueAnimation() {
    //        loading.startRotate()
    //    }
}

extension BaseViewController {
    
    // MARK: - Loading
    //    func showLoading(timeout: TimeInterval = BaseRouter.timeOut, customView: UIView? = nil, animated: Bool = true) {
    //        isLoading = true
    //        UIView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideLoading(animated:)), object: nil)
    //        perform(#selector(hideLoading(animated:)), with: nil, afterDelay: timeout)
    //        KVLoading.show(customView, animated: animated)
    //    }
    //
    //    func showLoadingInView(_ view: UIView, timeout: TimeInterval = BaseRouter.timeOut, customView: UIView? = nil, animated: Bool = true) {
    //        isLoading = true
    //        UIView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideLoading(animated:)), object: nil)
    //        perform(#selector(hideLoading(animated:)), with: nil, afterDelay: timeout)
    //        KVLoading.showInView(view: view, customView: customView, animated: animated)
    //    }
    //
    //    @objc func hideLoading(animated: Bool = true) {
    //        isLoading = false
    //        KVLoading.hide(animated: animated)
    //    }
}
extension UIViewController
{
    func showAlertControllerFromExtension(title: String, message: String, okTitle: String = "OK".uppercased(), okAction: (() -> Void)?) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: okTitle.uppercased(), style: .cancel) { (okButton) in
            okAction?()
        })
        self.present(alertController, animated: true, completion: nil)
    }
}
extension BaseViewController {
    
    // MARK: - Alerts
    func showAlertController(title: String, message: String, okTitle: String = "OK".uppercased(), okAction: (() -> Void)?) {
        self.showAlertControllerFromExtension(title: title, message: message, okAction: okAction)
    }
    
    func showAlertController(title: String, message: String, cancelTitle: String = "cancel".uppercased(), cancelAction: (() -> Void)?, okTitle: String = "OK".uppercased(), okAction: (() -> Void)?) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: cancelTitle.uppercased(), style: .default) { (cancelButton) in
            cancelAction?()
        })
        alertController.addAction(UIAlertAction(title: okTitle.uppercased(), style: .default) { (cancelButton) in
            okAction?()
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertController(title: String, message: String, secureTextEntry: Bool = true, textfieldPlaceholder: String, keyboardType: UIKeyboardType = .default, cancelTitle: String = "huy-bo".uppercased(), cancelAction: (() -> Void)?, okTitle: String = "OK".uppercased(), okAction: ((String) -> Void)?) {
        var inputTextField: UITextField?
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textfield) in
            if secureTextEntry {
                textfield.isSecureTextEntry = true
            }
            textfield.placeholder = textfieldPlaceholder
            textfield.keyboardType = keyboardType
            textfield.borderStyle = .roundedRect
            inputTextField = textfield
        }
        alertController.addAction(UIAlertAction(title: cancelTitle.uppercased(), style: .default) { (cancelButton) in
            cancelAction?()
        })
        alertController.addAction(UIAlertAction(title: okTitle.uppercased(), style: .default) { (cancelButton) in
            if let password = inputTextField?.text {
                okAction?(password)
            }
        })
        self.present(alertController, animated: true, completion: nil)
        
        if let textFields = alertController.textFields {
            for textfield in textFields {
                let container = textfield.superview
                let effectView = container?.superview?.subviews[0]
                if effectView is UIVisualEffectView {
                    container?.backgroundColor = .clear
                    effectView?.removeFromSuperview()
                }
            }
        }
    }
    
    //Huypn: add show unknow message
    func showUnknowErrorMessage(){
        self.showAlert(type: .Error, message: "Đã có lỗi xảy ra")
    }
    
    func showErrorMessage(message : String){
        self.showAlert(type: .Error, message: message)
    }
    
    func showNoticeMessage(message : String){
        self.showAlert(type: .Notice, message: message)
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let view = touch.view {
            if view is UIButton {
                return false
            }
        }
        
        if self.selectedRightMenu == true {
            //            if self.rightMenuView != touch.view {
            //                self.selectedRightMenu = false
            //                return false
            //            }
        }
        
        return true
    }
}

extension BaseViewController {
    
    // MARK: - Interaction events
    func ignoringInteractionEvents(_ status: Bool) {
        if status {
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

extension BaseViewController {
    
    // MARK: - Keyboard notifications
    func registerForKeyboardNotifications() {
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func destroyForKeyboardNotifications() {
        //        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        //        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
}

extension BaseViewController {
    
    // MARK: - Reachability
    //    func registerForReachabilityNotifications() {
    //        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
    //        do {
    //            try reachability.startNotifier()
    //        } catch {}
    //    }
    //
    //    func destroyForReachabilityNotifications() {
    //        reachability.stopNotifier()
    //        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    //    }
    
    @objc func reachabilityChanged(_ notification: Notification) {
        
    }
}

extension BaseViewController {
    
    // MARK: - Background mode
    //    func registerForBackgroundNotifications() {
    //        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: .UIApplication.willEnterForegroundNotification, object: nil)
    //        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive(_:)), name: .UIApplication.didBecomeActiveNotification, object: nil)
    //    }
    //
    //    func destroyForBackgroundNotifications() {
    //        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
    //        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    //    }
    //
    //    @objc func willEnterForeground(_ notification: Notification) {
    //
    //    }
    //
    //    @objc func didBecomeActive(_ notification: Notification) {
    //        if isLoading {
    //            loading.startRotate()
    //        }
    //    }
}

extension BaseViewController {
    //    func goStation() {
    //        KVLoading.show()
    //        StationInOutManager.sharedInstance.autoDetectNotOutStation { (station: StationModel?) in
    //            KVLoading.hide()
    //            var controller: BaseNavigationController?
    //            if let model = station{
    //                controller = Storyboard.stationInOut.stationNavigationController() as BaseNavigationController
    //                let stationRootVC = controller?.viewControllers.first as! StationInOutInfoViewController
    //                stationRootVC.notOutStation = model
    //            } else {
    //                controller = Storyboard.stationInOut.stationNavigationController() as BaseNavigationController
    //            }
    //
    //            if let slideMenuController = self.slideMenuController(), let controller = controller {
    //                slideMenuController.changeMainViewController(controller, close: true)
    //            }
    //            self.selectedRightMenu = false
    //        }
    //    }
    //
    //    func callSupport() {
    //        let alertController = UIAlertController(title: VTLocalizedString.localized(key: "callSupport"), message: VTLocalizedString.localized(key: "call19001600"), preferredStyle: UIAlertControllerStyle.alert)
    //        alertController.addAction(UIAlertAction(title: VTLocalizedString.localized(key: "CÓ"), style: UIAlertActionStyle.default, handler:{(alertAction) in
    //            if let url = URL(string: "tel://\(1789)"), UIApplication.shared.canOpenURL(url) {
    //                if #available(iOS 10, *) {
    //                    UIApplication.shared.open(url)
    //                } else {
    //                    UIApplication.shared.openURL(url)
    //                }
    //            }
    //        }))
    //        alertController.addAction(UIAlertAction(title: VTLocalizedString.localized(key: "KHÔNG"), style: UIAlertActionStyle.default, handler:nil))
    //        present(alertController, animated: true, completion: nil)
    //        self.selectedRightMenu = false
    //    }
    //
    //    func checkVersion() {
    //        let version = "Version:" + String((Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String) ?? "")
    //        let alertController = UIAlertController(title: VTLocalizedString.localized(key: "Thông tin version app"), message: version, preferredStyle: UIAlertControllerStyle.alert)
    //        alertController.addAction(UIAlertAction(title: VTLocalizedString.localized(key: "OK"), style: UIAlertActionStyle.default, handler:nil))
    //        present(alertController, animated: true, completion: nil)
    //        self.selectedRightMenu = false
    //    }
}

extension BaseViewController {
    func showAlertWith(type: AlertType, message: String, completion: @escaping() -> Void) {
        
        let alertVC = alertService.showAlertWith(type: type, message: message, completion: completion)
        alertVC.modalPresentationStyle = .overFullScreen
        present(alertVC, animated: false, completion: nil)
    }
    
    func showAlert(type: AlertType, message: String) {
        let alertVC = alertService.showAlert(type: type, message: message)
        alertVC.modalPresentationStyle = .overFullScreen
        present(alertVC, animated: false, completion: nil)
    }
    
    //cuongdd - add for nims
    func showAlertWithConfirm(type: AlertType, message: String, completionClose: @escaping() -> Void,  completionOK: @escaping() -> Void) {
        
        let alertVC = alertService.showAlertWithConfirm(type: type, message: message, completionClose: {
            
        }, completionOK: {
            
        })
        alertVC.modalPresentationStyle = .overFullScreen
        present(alertVC, animated: false, completion: nil)
    }
    
}


//extension BaseViewController: RightMenuViewDelegate {

//MARK: - Right menu view delegate
//    func selectAction(_ actionType: RightMenuAction) {
//        switch actionType {
//        case .goStation:
//            self.goStation()
//            break
//
//        case .callSupport:
//            self.callSupport()
//            break
//
//        case .checkVersion:
//            self.checkVersion()
//            break
//        }
//    }
//
//    func getDateTimeWith(dateString: String, isDate: Bool) -> String {
//        if let stringDate = dateString.toDateWithFormat("yyyy/MM/dd HH:mm:ss") {
//            let stringReturn = isDate ? stringDate.toString("dd/MM/yyyy") : stringDate.toString("HH:mm:ss")
//            return stringReturn
//        } else if let stringDate = dateString.toDateWithFormat("dd/MM/yyyy HH:mm:ss"){
//            let stringReturn = isDate ? stringDate.toString("dd/MM/yyyy") : stringDate.toString("HH:mm:ss")
//            return stringReturn
//        } else {
//            return ""
//        }
//    }
//    func convertDateFormatter(dateString: String) -> String {
//        if let stringDate = dateString.toDateWithFormat("yyyy/MM/dd HH:mm:ss") {
//            let stringReturn = stringDate.toString("dd/MM/yyyy HH:mm:ss")
//            return stringReturn
//        } else {
//            return ""
//        }
//    }
//
//    func renderDateTimeWith(dateString: String, isDate: Bool) -> String {
//        if let stringDate = dateString.toDateWithFormat("dd/MM/yyyy HH:mm:ss") {
//            let stringReturn = isDate ? stringDate.toString("dd/MM/yyyy") : stringDate.toString("HH:mm:ss")
//            return stringReturn
//        } else {
//            return ""
//        }
//    }
//}
