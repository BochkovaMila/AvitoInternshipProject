//
//  ViewController.swift
//  AvitoInternshipProject
//
//  Created by Mila B on 19.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var titleName: String?
    private var companyModel: Model?
    private var selectedEmployee: Employee!
    private var EmployeeArray = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataProvider.shared.fetchData {  Model in
            guard let employees = Model.company.employees, let name = Model.company.name else { return }
                
            self.companyModel = Model
            self.titleName = name
            self.EmployeeArray = employees
            self.EmployeeArray.sort { $0.name! < $1.name! }
            
            self.tableView.reloadData()
            self.title = self.titleName
        }

        if let error = DataProvider.error {
            self.title = error.localizedDescription
            adjustLargeTitleSize()
            tableView.reloadData()
        }
    }
    
    
    // MARK: - tableView SetUp

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            if let name = self.EmployeeArray[indexPath.row].name {
                cell.textLabel?.text = name
            }
            if let phone = self.EmployeeArray[indexPath.row].phone_number {
                cell.textLabel?.text?.append(" \(phone)")
            }
            cell.detailTextLabel?.text = ""
            for skill in self.EmployeeArray[indexPath.row].skills! {
                cell.detailTextLabel?.text?.append("\(skill) ")
            }
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.EmployeeArray.count
    }
    
}

// MARK: UIViewController Extension

extension UIViewController {
  func adjustLargeTitleSize() {
      guard let title = self.navigationItem.title else { return }

    let maxWidth = UIScreen.main.bounds.size.width - 60
    var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
      var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width

    while width > maxWidth {
      fontSize -= 1
        width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
    }

    navigationController?.navigationBar.largeTitleTextAttributes =
      [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)
    ]
  }
}
