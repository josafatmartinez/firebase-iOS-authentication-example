//
//  LoginViewController.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 27/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var viewProgress: UIActivityIndicatorView!
  private var presenter = LoginPresenter(loginService: LoginService())
  private var user: User?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    presenter.attachView(loginDelegate: self)
  }
  @IBAction func login() {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    presenter.login(withEmail: email, password: password)
  }
}
extension LoginViewController: LoginDelegate {
  func startLoading() {
    viewProgress.startAnimating()
    viewProgress.isHidden = false
  }
  
  func finishLoading() {
    viewProgress.stopAnimating()
    viewProgress.isHidden = true
  }
  
  func loginSuccess(withUser user: User) {
    self.user = user
    let storyboard: UIStoryboard = UIStoryboard(name: presenter.storyboardName, bundle: Bundle.main)
    let controller: TabBarViewController = TabBarViewController()
    let nextViewController: TabBarViewController = storyboard.instantiateViewController(identifier: controller.identifier)
    nextViewController.modalPresentationStyle = .overFullScreen
    nextViewController.modalTransitionStyle = .crossDissolve
    self.present(nextViewController, animated: true, completion: nil)
  }
  
  func loginError(error: NSError) {
    print(error.localizedDescription)
    emailTextField.isSelected = true
    emailTextField.text = ""
    passwordTextField.text = ""
    let alert = UIAlertController(title: "Error ❌", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
}
