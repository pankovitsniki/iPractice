//
//  ColorExtensions.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 11/28/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let background = UIColor(red: 0.9569, green: 0.9176, blue: 0.9686, alpha: 1.0)
//    UIColor(red: 0.1765, green: 0.3412, blue: 0.7686, alpha: 1.0)
    static let foreground = UIColor.white
//    static let tint = UIColor(red: 0.549, green: 0.7608, blue: 0.9647, alpha: 1.0)
    static let tint = UIColor(red: 0.051, green: 0.1098, blue: 0.5098, alpha: 1.0) // dark blue
    
    static let barChartMain = UIColor.white
    
    class func randomColor(seed: String) -> UIColor {
        
        var total: Int = 0
        for u in seed.unicodeScalars {
            total += Int(UInt32(u))
        }
        
        srand48(total * 200)
        let r = CGFloat(drand48())
        
        srand48(total)
        let g = CGFloat(drand48())
        
        srand48(total / 200)
        let b = CGFloat(drand48())
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
