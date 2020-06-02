//
//  ViewController.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 27/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if Auth.auth().currentUser != nil {
      // User is signed in.
      // ...
     print("User is signed in.")
      DispatchQueue.main.async {
        let storyboard: UIStoryboard = UIStoryboard(name: "Landing", bundle: Bundle.main)
        let controller: TabBarViewController = TabBarViewController()
        let nextViewController: TabBarViewController = storyboard.instantiateViewController(identifier: controller.identifier)
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.modalTransitionStyle = .crossDissolve
        self.present(nextViewController, animated: true, completion: nil)
      }
    } else {
      // No user is signed in.
      // ...
     print("No user is signed in.")
    }
  }
}
