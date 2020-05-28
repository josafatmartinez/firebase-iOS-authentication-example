//
//  AccountService.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation
import FirebaseAuth

class AccountService {
  func register(withAccount account: Account, _ completionHandler: @escaping (_ user: User?, _ error: NSError?) -> Void) {
    Auth.auth().createUser(withEmail: account.email, password: account.password) { (result, error) in
      if let result = result, error == nil {
        guard let email = result.user.email else { return }
        let user: User = .init(name: result.user.displayName ?? "Unknown", email: email)
        completionHandler(user, nil)
      } else {
        completionHandler(nil, error as NSError?)
      }
    }
  }
}
