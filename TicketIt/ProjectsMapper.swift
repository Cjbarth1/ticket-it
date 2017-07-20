//
//  ProjectsMapper.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ProjectsMapper {
  static func mapToProjects(json: JSON) -> [Project] {
    var projects = [Project]()
    guard let jsonArray = json.array else { return projects }
    for project in jsonArray {
      projects.append(mapToProject(json: project))
    }
    return projects
  }
  
  static func mapToProject(json: JSON) -> Project {
    let id = json["id"].stringValue
    let name = json["name"].stringValue
    let key = json["key"].stringValue
    return Project(id: id, name: name, key: key)
  }
}
