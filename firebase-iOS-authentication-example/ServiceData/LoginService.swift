//
//  LoginService.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginService {
  func login(withEmail email: String, password: String, _ completionHandler: @escaping (_ user: User?, _ error: NSError?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      if let result = result, error == nil {
        guard let email = result.user.email else { return }
        guard let displayName = result.user.displayName else { return }
        let user: User = .init(name: displayName, email: email)
        completionHandler(user, nil)
      } else {
        completionHandler(nil, error as NSError?)
      }
    }
  }
}
