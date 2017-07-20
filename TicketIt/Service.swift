//
//  Service.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import Alamofire

protocol Service {
  var path: String { get }
  var headers: HTTPHeaders { get }
  var body: Parameters { get }
  var method: HTTPMethod { get }
  var encoding: ParameterEncoding { get }
}

extension Service {
  var url: URL? {
    return URL(string: path)
  }
}
