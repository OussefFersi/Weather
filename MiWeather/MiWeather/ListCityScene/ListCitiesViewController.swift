//
//  ListCitiesViewController.swift
//  MiWeather
//
//  Created by oussef on 09/03/2023.
//

import UIKit

class ListCitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "My Cities"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTappedAction))
    }

    @objc func addTappedAction(){
        let addCityVC = AddCityViewController()
        self.navigationController?.pushViewController(addCityVC, animated: true)
    }
}

