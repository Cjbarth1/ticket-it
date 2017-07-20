//
//  TicketItManager.swift
//  TicketIt
//
//  Created by Casey Barth on 7/14/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation

struct TicketItManager {
  
  typealias TicketManagerCompletion = (Bool) -> Void
  
  static func generateFromFile(fromPath path: String, project: Project, completion: @escaping TicketManagerCompletion) {
    let manager = FileManager.default
    if manager.fileExists(atPath: path) {
      do {
        let csvContent = try String(contentsOfFile: path)
        let cleanedCSVContent = cleanRows(file: csvContent)
        let parser = CSVParser()
        let results = parser.mapToTickets(fromContents: cleanedCSVContent, project: project)
        self.createJiraTickets(tickets: results) { result in
          completion(result)
        }
      }
      catch {
        completion(false)
      }
    } else {
      completion(false)
    }
  }
  
  static func createJiraTickets(tickets: [JiraTicket], completion: @escaping TicketManagerCompletion) {
    var ticketsBody = [String: Any]()
    ticketsBody["issueUpdates"] = tickets.map({ TicketMapper.mapToJson(ticket: $0) })
    API.request(service: TicketService.createTickets(ticketJson: ticketsBody)) { response in
      completion(response.result.isSuccess)
    }
  }
  
  static func cleanRows(file: String) -> String{
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
  }
}

