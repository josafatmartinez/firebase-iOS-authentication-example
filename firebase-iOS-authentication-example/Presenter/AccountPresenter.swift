//
//  AccountPresenter.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation

protocol AccountDelegate: NSObjectProtocol {
  func startLoading()
  func finishLoading()
  func register(with account: Account)
}

class AccountPresenter {
  // MARK: - Private
  private let accountService: AccountService
  weak private var accountDelegate: AccountDelegate?
  
  init(accountService: AccountService) {
    self.accountService = accountService
  }
  func attachView(_ attach: Bool, view: AccountDelegate?) {
      if attach {
        self.accountDelegate = nil
      } else {
          if let view = view { self.accountDelegate = view }
      }
  }
  func detachView() {
      self.accountDelegate = nil
  }
  
}
