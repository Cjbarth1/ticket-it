//
//  ProjectService.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import Alamofire

enum ProjectService: Service {
  case getProjects(base64Auth: String)

  var path: String {
    guard let host = UserCache.host else { return "" }
    
    switch self {
      case .getProjects: return "\(host)/rest/api/latest/project"
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    switch self {
    case let .getProjects(authString):
      headers["Authorization"] = "Basic \(authString)"
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
  
  var body: Parameters {
    return [:]
  }
  
  var method: HTTPMethod {
    switch self {
    case .getProjects: return .get
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .getProjects: return URLEncoding.default
    }
  }
}
