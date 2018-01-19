//
//  ViewController.swift
//  xcodemysql
//
//  Created by Luis José Sánchez Carrasco on 2/1/18.
//  Copyright © 2018 Luis José Sánchez Carrasco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {

    @IBOutlet weak var tableView: UITableView!
    var feedItems: NSArray = NSArray()
    var selectedLocation : LocationModel = LocationModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "cell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.cosa
        
        return myCell
    }

}

