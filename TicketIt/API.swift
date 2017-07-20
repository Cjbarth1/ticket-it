//
//  API.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct API {
  static func request(service: Service, completion: @escaping (DataResponse<Any>) -> Void ) {
    guard let url = service.url else { return }
    print(service.body)
    Alamofire.request(url, method: service.method, parameters: service.body, encoding: service.encoding, headers:service.headers)
      .validate()
      .responseJSON { response in
        if response.result.isSuccess {
          if let data = response.request?.httpBody {
            let json = JSON(data: data)
            print(json)
          }
        }
        completion(response)
    }
  }
}
