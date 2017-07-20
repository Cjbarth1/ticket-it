//
//  UserCache.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import SAMKeychain

struct UserCache {
  fileprivate static let ticketItService = "TicketIt"
  fileprivate static let tokenAccount = "token"
  fileprivate static let hostAccount = "host"
  
  static var token: String? {
    get {
      return SAMKeychain.password(forService: ticketItService, account: tokenAccount)
    }
    set {
      if let tokenValue = newValue {
        SAMKeychain.setPassword(tokenValue, forService: ticketItService, account: tokenAccount)
      } else {
        SAMKeychain.deletePassword(forService: ticketItService, account: tokenAccount)
      }
      
    }
  }
  
  static var host: String? {
    get {
      return SAMKeychain.password(forService: ticketItService, account: hostAccount)
    }
    set {
      if let tokenValue = newValue {
        SAMKeychain.setPassword(tokenValue, forService: ticketItService, account: hostAccount)
      } else {
        SAMKeychain.deletePassword(forService: ticketItService, account: hostAccount)
      }
      
    }
  }
}

extension UserCache {
  static func generateBase64(from email: String, password: String) -> String? {
    guard email != "", password != "" else { return nil }
    let encodingString = "\(email):\(password)"
    if let data = encodingString.data(using: .utf8) {
      return data.base64EncodedString()
    }
    return nil
  }
}



