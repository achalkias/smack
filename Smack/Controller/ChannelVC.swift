//
//  ChannelVC.swift
//  Smack
//
//  Created by Apostolos Chalkias on 18/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Change the reveal width
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

   

  
}