//
//  LoginVC.swift
//  Smack
//
//  Created by Apostolos Chalkias on 18/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //Outlets
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

   
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func createAccountPressed(_ sender: Any) {
         performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
  
}
