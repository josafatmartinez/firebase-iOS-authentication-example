//
//  LoginPresenter.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation
protocol LoginDelegate: NSObjectProtocol {
   func startLoading()
   func finishLoading()
   func loginSuccess(withUser user: User)
   func loginError(error: NSError)
}

class LoginPresenter {
  private let loginService: LoginService
  weak private var loginDelegate: LoginDelegate?
  var storyboardName: String {
    return "Landing"
  }
  init(loginService: LoginService) {
    self.loginService = loginService
  }
  func attachView(loginDelegate: LoginDelegate) {
      self.loginDelegate = loginDelegate
  }
  func detachView() {
      self.loginDelegate = nil
  }
  func login(withEmail email: String, password: String) {
    loginDelegate?.startLoading()
    loginService.login(withEmail: email, password: password) { (user, error) in
      if let user = user, error == nil {
        self.loginDelegate?.finishLoading()
        self.loginDelegate?.loginSuccess(withUser: user)
      } else {
        self.loginDelegate?.finishLoading()
        guard let error = error else { return }
        self.loginDelegate?.loginError(error: error)
      }
    }
  }
}
