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
        self.updateAccount(name: account.name) { (error) in
          if error == nil {
            guard let email = result.user.email else { return }
            guard let displayName = result.user.displayName else { return }
            let user: User = .init(name: displayName, email: email)
            completionHandler(user, nil)
          } else {
            let error = NSError(
              domain: "com.example.error",
              code: 0,
              userInfo: [NSLocalizedDescriptionKey: "We tried to create the user but it resulted in an error"]
            )
            completionHandler(nil, error as NSError?)
          }
        }
      } else {
        completionHandler(nil, error as NSError?)
      }
    }
  }
  fileprivate func updateAccount(name displayName: String, _ completionHandler: @escaping (_ error: UserProfileChangeCallback?) -> Void) {
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.displayName = displayName
    changeRequest?.commitChanges(completion: { (error) in
      if error != nil {
        completionHandler(error as? UserProfileChangeCallback)
      } else {
        completionHandler(nil)
      }
    })
  }
}
