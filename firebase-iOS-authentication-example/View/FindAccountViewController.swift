//
//  FindAccountViewController.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 27/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import UIKit

class FindAccountViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "restorePassword" {
      if let destination = segue.destination as? RestorePasswordViewController {
        guard let email = emailTextField.text else { return }
        destination.email = email
      }
    }
  }
  
}
