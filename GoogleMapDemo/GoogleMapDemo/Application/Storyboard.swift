//
//  Storyboard.swift
//  GoogleMapDemo
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import UIKit

struct Storyboard {
    
}

extension Storyboard {
    
    struct Main {
        static let manager = UIStoryboard(name: "Main", bundle: nil)
        
        static func makerVC() -> MakerVC {
            return manager.instantiateViewController(withIdentifier: "MakerVC") as! MakerVC
        }
        
    }
}
