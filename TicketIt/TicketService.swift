//
//  TicketService.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import Alamofire

enum TicketService: Service {
  case createTickets(ticketJson: [String: Any])
  
  var path: String {
    guard let host = UserCache.host else { return "" }
    switch self {
    case .createTickets: return "\(host)/rest/api/latest/issue/bulk"
    }
  }
  
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    switch self {
    case .createTickets:
      headers["Authorization"] = "Basic \(UserCache.token ?? "")"
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
  
  var body: Parameters {
    switch self {
    case let .createTickets(body):
      return body
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .createTickets: return .post
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .createTickets: return JSONEncoding.default
    }
  }
}
