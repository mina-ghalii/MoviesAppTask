//
//  ViewHandler.swift
//  Privi
//
//  Created by Mina Atef on 5/1/20.
//  Copyright © 2020 Mina Atef. All rights reserved.
//

import UIKit

class ViewDesignHandler: UIView {
    
    @IBInspectable var viewBorderColor:  UIColor = .darkGray {
        didSet {
            self.layer.borderColor = viewBorderColor.cgColor
            self.layer.borderWidth = 1.0
        }
    }
    
    @IBInspectable var cornerR:  CGFloat = 0 {
        didSet {
            
             self.layer.cornerRadius = cornerR
        }
    }
    
    @IBInspectable var shadow:  CGFloat = 0 {
        didSet {
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: shadow)
            layer.shadowOpacity = 0.2
            layer.shadowRadius = shadow
        }
    }
    
    
    
    

    

}


class GradientView: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor.black.cgColor]
    }
}
