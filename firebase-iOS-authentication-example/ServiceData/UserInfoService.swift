//
//  UserInfoService.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 30/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation
import FirebaseAuth
class UserInfoService {
  func getUserData(_ completionHandler: @escaping (_ user: User?, _ error: NSError?) -> Void) {
    let user = Auth.auth().currentUser
    if let user = user {
      guard let name = user.displayName else { return }
      guard let email = user.email else { return  }
      let userData: User = .init(name: name, email: email)
      completionHandler(userData, nil)
      var multiFactorString = "MultiFactor: "
      for info in user.multiFactor.enrolledFactors {
        multiFactorString += info.displayName ?? "[DispayName]"
        multiFactorString += " "
      }
      print(multiFactorString)
    } else {
      let error = NSError(
        domain: "com.example.error",
        code: 0,
        userInfo: [NSLocalizedDescriptionKey: "We tried to search the user but it resulted in an error"]
      )
      completionHandler(nil, error as NSError?)
    }
  }
  func logout() {
    do {
      try Auth.auth().signOut()
    } catch {
      fatalError()
    }
  }
}
