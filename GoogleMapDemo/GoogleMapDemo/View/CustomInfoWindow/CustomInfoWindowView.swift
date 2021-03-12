//
//  CustomInfoWindowView.swift
//  GoogleMapDemo
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import UIKit

class CustomInfoWindowView: UIView {
    
    @IBOutlet weak var customWindowLabel: UILabel!
    
    @IBOutlet weak var viettelImageView: UIImageView!
    @IBOutlet weak var vinaImageView: UIImageView!
    @IBOutlet weak var mobiImageView: UIImageView!
    
    
    
    @IBAction func press(_ sender: UIButton) {
        self.customWindowLabel.text = "Tao vừa ấn vào đây"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadView() -> CustomInfoWindowView {
        let customInfoWindow = Bundle.main.loadNibNamed("CustomInfoWindowView", owner: self, options: nil)?[0] as! CustomInfoWindowView
        return customInfoWindow
    }
}

