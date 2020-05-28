//
//  Account.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation

enum AccountState: String {
  case new = "ACCOUNT_NEW"
  case updated = "ACCOUNT_UPDATED"
}

struct Account {
  let name: String
  let email: String
  let password: String
  let state: AccountState
}
