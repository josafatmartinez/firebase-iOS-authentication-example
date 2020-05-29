//
//  RestorePasswordViewController.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 27/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import UIKit

class RestorePasswordViewController: UIViewController {
  
  @IBOutlet weak var userEmailText: UILabel!
  @IBOutlet weak var viewProgress: UIActivityIndicatorView!
  public var email: String?
  private var presenter: RestorePasswordPresenter = RestorePasswordPresenter(restorePasswordService: RestorePasswordService())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    userEmailText.text = email
    presenter.attachView(restorePasswordDelegate: self)
  }
  
  fileprivate func loginAgain() {
    let storyboard: UIStoryboard = UIStoryboard(name: presenter.storyboardName, bundle: Bundle.main)
    let controller: LoginViewController = LoginViewController()
    let nextViewController: LoginViewController = storyboard.instantiateViewController(identifier: controller.identifier)
    nextViewController.modalPresentationStyle = .overFullScreen
    nextViewController.modalTransitionStyle = .crossDissolve
    self.present(nextViewController, animated: true, completion: nil)
  }
  @IBAction func sendEmail() {
    guard let email = email else { return }
    presenter.sendPasswordReset(withEmail: email)
  }
}
extension RestorePasswordViewController: RestorePasswordDelegate {
  func startLoading() {
    viewProgress.startAnimating()
    viewProgress.isHidden = false
  }
  
  func finishLoading() {
    viewProgress.stopAnimating()
    viewProgress.isHidden = true
  }
  
  func restorePasswordSuccess(withmessage message: String) {
    let alert = UIAlertController(title: "Success 📧 ✅", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Amazing", style: .default, handler: { _ in
      self.loginAgain()
    }))
    self.present(alert, animated: true)
  }
  
  func restorePasswordError(error: NSError) {
    let alert = UIAlertController(title: "Error 📧 ❌", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Try later", style: .destructive, handler: { _ in
      self.loginAgain()
    }))
    self.present(alert, animated: true)
  }
  
}
