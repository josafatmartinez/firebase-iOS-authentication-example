//
//  UserInfoPresenter.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 30/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import Foundation
protocol UserInfoDelegate: NSObjectProtocol {
  func startLoading()
  func finishLoading()
  func fetchUserInformationData(user: User)
  func fetchUserInformationData(error: NSError)
}
class UserInfoPresenter {
  // MARK: - Private
  private let userInfoService: UserInfoService
  weak private var userInfoDelegate: UserInfoDelegate?
  var identifier: String {
    return "Main"
  }
  
  init(userInfoService: UserInfoService) {
    self.userInfoService = userInfoService
  }
  func attachView(userInfoDelegate: UserInfoDelegate) {
    self.userInfoDelegate = userInfoDelegate
  }
  func detachView() {
    self.userInfoDelegate = nil
  }
  func getUserData() {
    self.userInfoService.getUserData { (user, error) in
      if let user = user, error == nil {
        self.userInfoDelegate?.fetchUserInformationData(user: user)
      } else {
        guard let error = error else { return }
        self.userInfoDelegate?.fetchUserInformationData(error: error)
      }
    }
  }
  func logout() {
    self.userInfoService.logout()
  }
}
