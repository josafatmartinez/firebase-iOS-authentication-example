//
//  RoundButton.swift
//  firebase-iOS-authentication-example
//
//  Created by Josafat Martínez  on 28/05/20.
//  Copyright © 2020 Josafat Martínez . All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor = UIColor.clear {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }
}
