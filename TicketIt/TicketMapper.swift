//
//  TicketMapper.swift
//  TicketIt
//
//  Created by Casey Barth on 7/14/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import SwiftyJSON

final class TicketMapper {
  
  // Columns enum defines the order in which they are parsed. This must match up with the columns in the csv
  enum Columns: Int {
    case summary
    case description
    case label
    case component
    case epic
  }
  
  typealias Model = JiraTicket
  
  func mapFromArray(_ ticketData: [String], project: Project) -> Model {
    
    print(ticketData)
    
    let summary = ticketData[Columns.summary.rawValue]
    let description = ticketData[Columns.description.rawValue]
    let label = ticketData[Columns.label.rawValue]
    let component = ticketData[Columns.component.rawValue]
    let epic = ticketData[Columns.epic.rawValue]
    
    let ticket = JiraTicket(
      summary: summary,
      description: description,
      label: label,
      component: component,
      epic: epic,
      project: project
    )
    
    return ticket
  }
  
  static func mapToJson(ticket: JiraTicket) -> [String: Any] {
    var body = [String: Any]()
    var innerBody = [String: Any]()
    
    let project = ["id": ticket.project.id]
    innerBody["project"] = project
    
    let type = ["name": "Story"]
    innerBody["issuetype"] = type
    
    innerBody["summary"] = ticket.summary
    innerBody["description"] = ticket.description ?? ""
    
    body["fields"] = innerBody
    return body
  }
}
