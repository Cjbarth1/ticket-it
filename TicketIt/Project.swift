//
//  Project.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation

final class Project: NSObject {
  var id: String
  var name: String
  var key: String
  
  init(id: String, name: String, key: String) {
    self.id = id
    self.name = name
    self.key = key
  }
  
}

extension Project: NSCopying {
  func copy(with zone: NSZone? = nil) -> Any {
    return type(of:self).copy(self)
  }
}
