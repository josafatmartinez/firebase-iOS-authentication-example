//
//  UserInfoViewController.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 30/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var viewProgress: UIActivityIndicatorView!
  private var presenter: UserInfoPresenter = UserInfoPresenter(userInfoService: UserInfoService())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      presenter.attachView(userInfoDelegate: self)
      presenter.getUserData()
    }
  @IBAction func updateUserInformation() {
    
  }
  @IBAction func logOutUser() {
    let alert = UIAlertController(title: "Exit 🔓", message: "Are you trying to log out?", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
      self.presenter.logout()
      let storyboard: UIStoryboard = UIStoryboard(name: self.presenter.identifier, bundle: Bundle.main)
      let controller: LoginViewController = LoginViewController()
      let nextViewController: LoginViewController = storyboard.instantiateViewController(identifier: controller.identifier)
      nextViewController.modalPresentationStyle = .overFullScreen
      nextViewController.modalTransitionStyle = .crossDissolve
      self.present(nextViewController, animated: true, completion: nil)
    }))
    alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
}
extension UserInfoViewController: UserInfoDelegate {
  func startLoading() {
    viewProgress.startAnimating()
    viewProgress.isHidden = false
  }
  
  func finishLoading() {
    viewProgress.startAnimating()
    viewProgress.isHidden = false
  }
  
  func fetchUserInformationData(user: User) {
    nameTextField.text = user.name
    emailTextField.text = user.email
  }
  
  func fetchUserInformationData(error: NSError) {
    print(error.localizedDescription)
    let alert = UIAlertController(title: "Error ❌", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
}
