//
//  pockemon.swift
//  Pockemon
//
//  Created by Ali Alshahrani on 1/5/19.
//  Copyright © 2019 Ali Alshahrani. All rights reserved.
//

import UIKit

class pockemon {
    
    var latitiude:Double?
    var longitude:Double?
    var image:String?
    var name:String?
    var des:String?
    var power:Double?
    var isCatched:Bool?
    
    init(latitiude:Double, longitude:Double, image:String, name:String, des:String, power:Double, isCatched:Bool) {
        
        self.latitiude = latitiude
        self.longitude = longitude
        self.image = image
        self.name = name
        self.des = des
        self.power = power
        self.isCatched = false
    }
    

}
