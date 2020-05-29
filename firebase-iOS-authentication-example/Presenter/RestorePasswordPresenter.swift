//
//  RestorePasswordPresenter.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation

protocol RestorePasswordDelegate: NSObjectProtocol {
  func startLoading()
  func finishLoading()
  func restorePasswordSuccess(withmessage message: String)
  func restorePasswordError(error: NSError)
}

class RestorePasswordPresenter {
  private let restorePasswordService: RestorePasswordService
  weak private var restorePasswordDelegate: RestorePasswordDelegate?
  var storyboardName: String {
    return "Main"
  }
  
  init(restorePasswordService: RestorePasswordService) {
    self.restorePasswordService = restorePasswordService
  }
  func attachView(restorePasswordDelegate: RestorePasswordDelegate) {
      self.restorePasswordDelegate = restorePasswordDelegate
  }
  func detachView() {
      self.restorePasswordDelegate = nil
  }
  func sendPasswordReset(withEmail email: String) {
    restorePasswordDelegate?.startLoading()
    restorePasswordService.sendPasswordReset(withEmail: email) { (error) in
      self.restorePasswordService.sendPasswordReset(withEmail: email) { (error) in
        self.restorePasswordDelegate?.finishLoading()
        if error == nil {
          let message: String = "The e-mail has been sent"
          self.restorePasswordDelegate?.restorePasswordSuccess(withmessage: message)
        } else {
          guard let error = error else { return }
          self.restorePasswordDelegate?.restorePasswordError(error: error)
        }
      }
      
    }
  }
}
