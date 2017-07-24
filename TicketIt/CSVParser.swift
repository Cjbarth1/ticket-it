//
//  CSVParser.swift
//  TicketIt
//
//  Created by Casey Barth on 7/14/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation

struct CSVParser {
  
  func mapToTickets(fromContents contents: String, project: Project) -> [JiraTicket] {
    
    var result = [JiraTicket]()
    let rows = contents.components(separatedBy: "\n")
    
    for (i, row) in rows.enumerated() where i != 0 {
      let columns = row.components(separatedBy: ",")
    
      if columns.count > 1 {
        let mapper = TicketMapper()
        let ticket = mapper.mapFromArray(columns, project: project, selectedType: .story)
        result.append(ticket)
      }
      
    }
    return result
  }
}
