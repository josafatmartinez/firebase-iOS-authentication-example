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
  func registerSuccess(withUser user: User)
  func registerError(error: NSError)
}

class AccountPresenter {
  // MARK: - Private
  private let accountService: AccountService
  weak private var accountDelegate: AccountDelegate?
  var storyboardName: String {
    return "Main"
  }
  
  init(accountService: AccountService) {
    self.accountService = accountService
  }
  func attachView(accountDelegate: AccountDelegate) {
      self.accountDelegate = accountDelegate
  }
  func detachView() {
      self.accountDelegate = nil
  }
  func register(withAccount account: Account) {
    accountDelegate?.startLoading()
    accountService.register(withAccount: account) { (user, error) in
      if let user = user, error == nil {
        self.accountDelegate?.finishLoading()
        self.accountDelegate?.registerSuccess(withUser: user)
      } else {
        self.accountDelegate?.finishLoading()
        guard let error = error else { return }
        self.accountDelegate?.registerError(error: error)
      }
    }
  }
}
