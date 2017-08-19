//
//  RoundedButton.swift
//  Smack
//
//  Created by Apostolos Chalkias on 19/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {

 
    @IBInspectable var cornerRadius: CGFloat = 3.0{
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }

}
