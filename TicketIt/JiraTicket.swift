//
//  JiraTicket.swift
//  TicketIt
//
//  Created by Casey Barth on 7/14/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation

enum TicketType: String {
  case story = "Story"
  case bug = "Bug"
  case task = "Task"
}

final class JiraTicket {
  var summary: String
  var description: String?
  var label: String?
  var component: String?
  var epic: String?
  var type: TicketType
  var project: Project
  
  init(summary: String,
       description: String?,
       label: String?,
       component: String?,
       epic: String?,
       type: TicketType,
       project: Project) {
    self.summary = summary
    self.description = description
    self.label = label
    self.component = component
    self.epic = epic
    self.type = type
    self.project = project
  }
}
