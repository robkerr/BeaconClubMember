//
//  Branding.swift
//  UserApp
//
//  Created by Rob Kerr on 5/4/15.
//  Copyright (c) 2015 A2B Mobile Toolworks, LLC. All rights reserved.
//

import Foundation
import UIKit

public enum BrandingColor : Int {
    case PrimaryBackground = 0, TextColor, ButtonBackground, TabBarBackground, TabBarStroke
}


public struct Branding {

    static func customColor(colorUsage : BrandingColor) -> UIColor {
    
        var color = UIColor.darkGrayColor()
        
        if let appColors = NSBundle.mainBundle().infoDictionary?["AppColors"] as? [NSDictionary] {
            
            let colorDict = appColors[colorUsage.rawValue]
            
            let colorName = colorDict["ColorUsage"] as! String
            
            let redValue = colorDict["Red"] as! CGFloat
            let greenValue = colorDict["Green"] as! CGFloat
            let blueValue = colorDict["Blue"] as! CGFloat
            
            color = UIColor(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: 1.0)
        }
        
        return color
    }
    
    static func setBrandingForView(view : UIView) {
        view.backgroundColor = Branding.customColor(.PrimaryBackground)
    }
    
    
}
