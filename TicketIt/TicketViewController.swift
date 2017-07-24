//
//  TicketViewController.swift
//  TicketIt
//
//  Created by Casey Barth on 7/14/17.
//  Copyright © 2017 teeps. All rights reserved.
//

import Cocoa

class TicketViewController: NSViewController {
  
  // Outlets
  @IBOutlet weak var projectsComboBox: NSComboBox!
  @IBOutlet weak var filePathField: NSTextField!
  @IBOutlet weak var statusLabel: NSTextField!
  @IBOutlet weak var typeComboBox: NSComboBox!
  
  // Computed
  fileprivate var dialog: NSOpenPanel = {
    
    let dialog = NSOpenPanel()
    dialog.title = "Choose a .csv file"
    dialog.showsResizeIndicator    = true
    dialog.showsHiddenFiles        = false
    dialog.canChooseDirectories    = true
    dialog.canCreateDirectories    = true
    dialog.allowsMultipleSelection = false
    return dialog
  }()

  // Data
  var projects: [Project]!
  fileprivate var selectedProject: Project?
  weak var delegate: TicketViewControllerDelegate?
  
  fileprivate var filePath: String = "" {
    didSet {
      self.filePathField.stringValue = filePath
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureComboBox()
    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  
  fileprivate func configureComboBox() {
    projectsComboBox.placeholderString = "Select Project"
    projectsComboBox.usesDataSource = true
    projectsComboBox.delegate = self
    projectsComboBox.dataSource = self
    projectsComboBox.isEditable = false
    
    typeComboBox.usesDataSource = false
    typeComboBox.delegate = self
    typeComboBox.isEditable = false
    
    typeComboBox.addItems(withObjectValues:
      [TicketType.story.rawValue, TicketType.task.rawValue, TicketType.bug.rawValue]
    )
  }


  // MARK: - Actions
  @IBAction func chooseFilePressed(_ sender: Any) {

    if (dialog.runModal() == NSModalResponseOK) {
      let result = dialog.url
      guard let path = result?.path else {
        return
      }
      filePath = path
    } else {
      return
    }
  }
  
  @IBAction func TicketItPressed(_ sender: Any) {
    guard let project = selectedProject, filePath != "" else { return }
    statusLabel.stringValue = "Generating tickets..."
    guard let ticketType = TicketType(rawValue: typeComboBox.objectValue as! String) else { return }
    
    TicketItManager.generateFromFile(fromPath: filePath, project: project, type: ticketType) { success in
      self.statusLabel.stringValue = success ? "Tickets Created Successfully!" : "Failed to create tickets"
    }
  }
  @IBAction func logoutPressed(_ sender: Any) {
    delegate?.didPressLogout()
  }
}

// MARK: - Projects CB Data Source
extension TicketViewController: NSComboBoxDataSource {
  func numberOfItems(in comboBox: NSComboBox) -> Int {
    return projects.count
  }
  
  func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
    return projects[index].name
  }
}

// MARK: - Projects CB Delegate
extension TicketViewController: NSComboBoxDelegate {
  func comboBoxSelectionDidChange(_ notification: Notification) {
    if (notification.object as! NSComboBox) == projectsComboBox {
      selectedProject = projects[projectsComboBox.indexOfSelectedItem]
    }
  }
}

protocol TicketViewControllerDelegate: class {
  func didPressLogout()
}

