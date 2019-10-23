//
//  AlbumDetailsViewController.swift
//  itunes_list
//
//  Created by __this__ on 10/22/19.
//  Copyright © 2019 __this__. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
