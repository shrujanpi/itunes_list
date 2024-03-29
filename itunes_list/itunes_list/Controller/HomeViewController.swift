//
//  HomeViewController.swift
//  itunes_list
//
//  Created by __this__ on 10/22/19.
//  Copyright © 2019 __this__. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var pulse1: UIView!
    @IBOutlet weak var pulse2: UIView!
    @IBOutlet weak var pulse3: UIView!
    
    var albumsArray = [Album]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        
        Service.fetchAppDetails { (albumDetails) -> Void in
            
            //Get the main thread to update the UI
            DispatchQueue.main.async {
                self.hideLoader()
                self.albumsArray = albumDetails
            }
        }
    }
    
    fileprivate func showLoader() {
        // animation stuff
        self.animationView.layer.zPosition = 1.0
        self.addPulseAnimation(to:self.pulse1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            self.addPulseAnimation(to:self.pulse2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.66) {
            self.addPulseAnimation(to:self.pulse3)
        }
    }
    
    fileprivate func hideLoader() {
        self.animationView.removeFromSuperview()
        DispatchQueue.main.async {
            self.tableView.layer.zPosition = 1.0
        }
    }
    
    fileprivate func configureViews() {
        self.title = "Albums"
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.red
        self.tableView.layer.zPosition = 0.9
        
        self.showLoader()
        
        // Status bar white font
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.createGradientLayer(forView: self.view)
        self.styleNavigationBar()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.lblAlbum.text = self.albumsArray[indexPath.row].albumName
        cell.lblArtist.text = self.albumsArray[indexPath.row].artistName
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = cell.imgArtwork.bounds
        
        if let thumbnailUrl = self.albumsArray[indexPath.row].thumbnail {
            
            if let _url = NSURL(string:thumbnailUrl) as URL? {
                if let imgData = NSData(contentsOf: _url) {
                    if let imageToLoad = UIImage(data: imgData as Data) {
                        cell.imgArtwork.image = imageToLoad
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
        detailsVC.album = self.albumsArray[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated:true)
    }
}
