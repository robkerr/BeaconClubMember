//****************************************************************************************
//
//          File:           CVBgRectView.swift
//          Project:        General Templates
//          Description:    A UIView that shows a rounded rectangle behind some other content
//
//          Date:           Created by Rob Kerr on 5/12/15
//          Copyright:      Copyright (c) Mobile Toolworks LLC. All rights reserved.
//
//*****************************************************************************************
import UIKit

@IBDesignable public class CVBgRectView: UIView {
    @IBInspectable public var customCornerRadius: NSNumber? {
        didSet {
            configureView()
        }
    }
    
    override public class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        
        configureView()
    }
    
    func configureView() {
        var radius = self.customCornerRadius ?? 5.0
        
        self.layer.cornerRadius =  CGFloat( radius.floatValue)
        self.layer.masksToBounds = true
    }
}