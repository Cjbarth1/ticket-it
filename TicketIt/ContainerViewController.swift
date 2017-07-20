//
//  ContainerViewController.swift
//  TicketIt
//
//  Created by Casey Barth on 7/17/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Cocoa

final class ContainerViewController: NSViewController {
  
  @IBOutlet weak var containerView: NSView!
  
  lazy var authenticationViewController: AuthenticationViewController = {
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateController(withIdentifier: "AuthenticationViewController")
    return controller as! AuthenticationViewController
  }()
  
  lazy var ticketViewController: TicketViewController = {
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateController(withIdentifier: "TicketViewController")
    return controller as! TicketViewController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presentInitialViewController()
  }
  
  func presentInitialViewController() {
    if let token = UserCache.token, let _ = UserCache.host {
      fetchProjects(withToken: token) { projects in
        self.presentTicketView(withProjects: projects)
      }
    } else {
      presentAuthentication()
    }
  }
  
  func userAuthenticated(with projects: [Project]) {
    authenticationViewController.view.removeFromSuperview()
    presentTicketView(withProjects: projects)
  }
  
  func presentAuthentication() {
    let authVC = authenticationViewController
    authVC.delegate = self
    containerView.addSubview(authenticationViewController.view)
  }
  
  func fetchProjects(withToken token: String, completion: @escaping ([Project]) -> Void) {
    let service = ProjectService.getProjects(base64Auth: token)
    API.request(service: service) { response in
      
      if response.result.isSuccess {
        if response.response?.statusCode == 200 {
          UserCache.token = token
        }
        
        if let data = response.data {
          let json = JSON(data: data)
          let projects = ProjectsMapper.mapToProjects(json: json)
          completion(projects)
        }
      } else {
        guard let error = response.result.error else { return }
        self.showError(error)
      }
    }
  }
  
  func showError(_ error: Error) {
    let alert = NSAlert(error: error)
    alert.addButton(withTitle: "Ok")
    alert.beginSheetModal(for:  NSApp.keyWindow!) { response in
      print("Bleh")
    }
  }
  
  func presentTicketView(withProjects projects: [Project]) {
    let ticketVC = ticketViewController
    ticketVC.delegate = self
    ticketVC.projects = projects
    containerView.addSubview(ticketVC.view)
  }
  
}

extension ContainerViewController: AuthenticationViewControllerDelegate {

  func didPressAuthenticate(_ host: String, email: String, password: String) {
    UserCache.host = host
    guard let token = UserCache.generateBase64(from: email, password: password) else { return }
    
    fetchProjects(withToken: token) { projects in
      self.userAuthenticated(with: projects)
    }
  }
  
}

extension ContainerViewController: TicketViewControllerDelegate {
  func didPressLogout() {
    UserCache.host = nil
    UserCache.token = nil
    ticketViewController.view.removeFromSuperview()
    ticketViewController.removeFromParentViewController()
    presentAuthentication()
  }
}

