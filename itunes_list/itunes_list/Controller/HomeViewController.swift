//
//  HomeViewController.swift
//  itunes_list
//
//  Created by __this__ on 10/22/19.
//  Copyright © 2019 __this__. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var albumsArray = [Album]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Albums"
        //Get the user data from App Service
        
        Service.fetchAppDetails { (albumDetails) -> Void in
            
            //Get the main thread to update the UI
            DispatchQueue.main.async {
                self.albumsArray = albumDetails
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
