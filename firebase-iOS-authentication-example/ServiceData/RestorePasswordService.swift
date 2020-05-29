//
//  RestorePasswordService.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation
import FirebaseAuth

class RestorePasswordService {
  func sendPasswordReset(withEmail email: String, _ completionHandler: @escaping (_ error: NSError?) -> Void) {
    Auth.auth().sendPasswordReset(withEmail: email) { (error) in
      if let error = error {
        completionHandler(error as NSError)
      } else {
        completionHandler(nil)
      }
    }
  }
}
