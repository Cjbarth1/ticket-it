//
//  AuthenticationViewController.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import Cocoa
import SwiftyJSON
import Alamofire

final class AuthenticationViewController: NSViewController {
  @IBOutlet weak var hostTextField: NSTextField!
  @IBOutlet weak var emailTextField: NSTextField!
  @IBOutlet weak var passwordTextField: NSSecureTextField!
  
  
  weak var delegate: AuthenticationViewControllerDelegate?
  
  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  
  @IBAction func authenticateUserTapped(_ sender: Any) {
    if validateFields() {
      delegate?.didPressAuthenticate(
        hostTextField.stringValue,
        email: emailTextField.stringValue,
        password: passwordTextField.stringValue
      )
    }
  }
  
  fileprivate func validateFields() -> Bool {
    guard !hostTextField.stringValue.isEmpty,
      !emailTextField.stringValue.isEmpty,
      !passwordTextField.stringValue.isEmpty else {
        return false
    }
    return true
  }
}

protocol AuthenticationViewControllerDelegate: class {
  func didPressAuthenticate(_ host: String, email: String, password: String)
}
