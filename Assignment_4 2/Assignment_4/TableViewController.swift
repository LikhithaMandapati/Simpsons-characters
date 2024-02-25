//
//  TableViewController.swift
//  Assignment_4
//
//  Created by student on 1/4/24.
//

import UIKit
    
class TableViewController: UITableViewController {
    private let viewModel = ViewModel()
    var selectedCharacter = ViewModel.Figure()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = viewModel.characters[indexPath.row]
        self.performSegue(withIdentifier: "seg_details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg_details" {
            let detailed_view = segue.destination as! ViewController
            detailed_view.character = selectedCharacter
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = cell.viewWithTag(1) as! UILabel
        
        name.text = "\(viewModel.characters[indexPath.row].name)"
        return cell
    }
}

