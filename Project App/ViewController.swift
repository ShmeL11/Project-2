//
//  ViewController.swift
//  Project App
//
//  Created by Mac on 12.03.2024.
//

import UIKit

class Project {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class ProjectsViewController: UIViewController {
    var projects = [Project]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Projects"
        
        setupTableView()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProject))
    }
    @objc func addProjecto() {
        let alertController = UIAlertController(title: "New Project", message: "Enter project name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Project name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let projectName = alertController.textFields?.first?.text {
                self.addProject(name: projectName)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
    
    @objc func addProject(name: String) {
        let project = Project(name: name)
        projects.append(project)
        tableView.reloadData()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(UITableView.self, forCellReuseIdentifier: "Cell")
    }
}

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let project = projects[indexPath.row]
        cell.textLabel?.text = project.name
        return cell 
    }
}

// Usage
let viewController = ProjectsViewController()
let navigationController = UINavigationController(rootViewController: viewController)
