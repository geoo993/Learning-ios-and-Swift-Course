//
//  DogsResultsTableViewController.swift
//  DogSearch
//
//  Created by GEORGE QUENTIN on 02/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

public class DogsResultsTableViewController: UITableViewController {

  
    var filteredDogs = [(name: String, image: UIImage)]()
    var dogsViewController : DogsTableViewController?
  
    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredDogs.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dogsResultsIdentifier", for: indexPath) as? DogsResultsTableViewCell else { return  DogsResultsTableViewCell() }
        
        cell.cellImage.image = filteredDogs[indexPath.item].image
        cell.cellTitleLabel.text = filteredDogs[indexPath.item].name
        //cell.textLabel?.text = filteredDogs[indexPath.item].name
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected:", filteredDogs[indexPath.item])
        
        let selection = self.filteredDogs[indexPath.row].name
        if let dogsController = self.dogsViewController{
            dogsController.scrollToSelectedRow(with: selection)
            dogsController.cancelSearch()
            dismiss(animated: true, completion: nil)
        }
        
    }

}
