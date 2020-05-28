//
//  CreateAccountViewController.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 27/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
  // MARK: - IBOutlets
  
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var viewProgress: UIActivityIndicatorView!
  
  // MARK: - Privates
  
  private var presenter = AccountPresenter(accountService: AccountService())
  private var user: User?
  
  // MARK: - ViewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    presenter.attachView(accountDelegate: self)
  }
  
  @IBAction func registerAccount(_ sender: Any) {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    let newAccount: Account = Account(name: "USER_TEST", email: email, password: password, state: .new)
    presenter.register(withAccount: newAccount)
  }
}

extension CreateAccountViewController: AccountDelegate {
  func startLoading() {
    viewProgress.startAnimating()
    viewProgress.isHidden = false
  }
  
  func finishLoading() {
    viewProgress.stopAnimating()
    viewProgress.isHidden = true
  }
  
  func registerSuccess(withUser user: User) {
    self.user = user
    let storyboard: UIStoryboard = UIStoryboard(name: presenter.storyboardName, bundle: Bundle.main)
    guard let identifier: String = LandingViewController().restorationIdentifier else { return }
    let nextViewController: LandingViewController = storyboard.instantiateViewController(identifier: identifier)
    self.present(nextViewController, animated: true, completion: nil)
  }
  
  func registerError(error: NSError) {
    print(error.localizedDescription)
    emailTextField.isSelected = true
    emailTextField.text = ""
    passwordTextField.text = ""
    let alert = UIAlertController(title: "Error ❌", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
}
