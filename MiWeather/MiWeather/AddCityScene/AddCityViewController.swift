//
//  AddCityViewController.swift
//  MiWeather
//
//  Created by oussef on 07/03/2023.
//

import UIKit
import MapKit

class AddCityViewController: UIViewController,UISearchBarDelegate {
    var viewModel:AddCityViewModel?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTable: UITableView!
    
    var onAddCity:(City) -> () = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add City"
        
        viewModel = AddCityViewModel()
        viewModel?.onReloadData = { [weak self] result in
            self?.searchResultsTable.reloadData()
        }
        viewModel?.onCityAdded = { [weak self] city in
            self?.navigationController?.popViewController(animated: true)
        }
        searchBar?.delegate = self
        searchResultsTable?.delegate = self
        searchResultsTable?.dataSource = self
        searchResultsTable?.register(SearchCityTableViewCell.self, forCellReuseIdentifier: "SearchCityTableViewCell")
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchCompleter.queryFragment = searchText
        if(searchText.isEmpty){
            viewModel?.restSearch()
        }
    }
        
        
}

extension AddCityViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchResults.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResult = viewModel?.searchResults[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityTableViewCell", for: indexPath) as? SearchCityTableViewCell{
            cell.textLabel?.text = searchResult?.title
            cell.detailTextLabel?.text = searchResult?.subtitle
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension AddCityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let result = viewModel?.searchResults[indexPath.row]{
            self.viewModel?.onSelectCity(cityResultItem: result)
        }
    }
}

