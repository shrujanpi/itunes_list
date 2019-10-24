//
//  AlbumDetailsViewController.swift
//  itunes_list
//
//  Created by __this__ on 10/22/19.
//  Copyright © 2019 __this__. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumDetailsViewController: BaseViewController, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var contentView: UIView!
    
    var album = Album() {
        didSet {
            guard let thumbnail = album.thumbnail,
                let albumName = album.albumName,
                let artist = album.artistName,
                let genre = album.genre,
                let releaseDate = album.releaseDate,
                let copyright = album.copyrightInfo,
                let link = album.iTunesLink else {
                    return
            }
            
            DispatchQueue.main.async {
                self.imgView.downloadImageFrom(link: thumbnail, contentMode: .scaleAspectFit)
                self.lblAlbum.text = albumName
                self.lblArtist.text = artist
                self.lblGenre.text = "Genre: \(genre)"
                self.lblReleaseDate.text = "Released on: \(releaseDate)"
                self.lblCopyright.text = "Copyright \(copyright)"
            }
        }
    }

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblAlbum: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblCopyright: UILabel!
    @IBOutlet weak var btnOpen: UIButton!
    
    @IBAction func btnOpeniTunes(_ sender: Any) {
        if let link = self.album.iTunesLink {
//            let linkArray = link.components(separatedBy: "/")
//            let linkString = link.replacingOccurrences(of: linkArray.last!, with: "")
            if let url =  URL(string: link) {
                print("link is \(link)")
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    fileprivate func configureViews() {
        self.createGradientLayer(forView: self.view)
        self.styleNavigationBar()
        
        self.contentView.layer.zPosition = 1.0
        self.btnOpen.layer.cornerRadius = 15.0
    }
}
