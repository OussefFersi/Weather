//
//  ListCitiesViewController.swift
//  MiWeather
//
//  Created by oussef on 09/03/2023.
//

import UIKit

class ListCitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListCitiesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "My Cities"
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(CityTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
        
        viewModel = ListCitiesViewModel()
        viewModel?.onCitiesReload = { [weak self] result in
            self?.tableView?.reloadData()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTappedAction))
    }

    @objc func addTappedAction(){
        let addCityVC = AddCityViewController()
        self.navigationController?.pushViewController(addCityVC, animated: true)
    }
}

extension ListCitiesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let city = viewModel?.cities[indexPath.row]{
            //go to detail view
        }
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let city = viewModel?.cities[indexPath.row] {
                self.viewModel?.removeCity(city: city)
            }
        }
    }
}

extension ListCitiesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cities.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let city = viewModel?.cities[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = city?.name
            
            return cell
        }
        
        return CityTableViewCell()
    }
}


