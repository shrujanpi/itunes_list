//
//  Service.swift
//  itunes_list
//
//  Created by __this__ on 10/22/19.
//  Copyright © 2019 __this__. All rights reserved.
//

import Foundation


struct Service {
    
    fileprivate static let baseURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/non-explicit.json"
    
    fileprivate static func constructURL() -> URL? {
        
        let appURLComponent = URLComponents(string: baseURL)
        
        return(appURLComponent?.url)
    }
    
    static func fetchAppDetails( _ completion: @escaping ([Album]) -> Void) {
        
        print("fetchAppDetails")
        if let url = constructURL(){
            
            let networkManager = NetworkManager.init(url: url)
            networkManager.getData({ (jsonDict) -> Void in
                print("==> \(jsonDict)")
                let appDetails = parseData(jsonDict)
                completion(appDetails)
            })
        }
        
    }
    
    static func parseData(_ jsonObj: [String:AnyObject]?) -> [Album]{
        
        var albums = [Album]()
        
        if let dict = jsonObj!["feed"] {
            if let results = dict["results"] as? [[String:AnyObject]] {
                for item in results {
                    
                    var _album = Album()
                    
                    if let _name = item["name"] as? String,
                        let _artistName = item["artistName"] as? String,
                        let _artworkUrl100 = item["artworkUrl100"] as? String,
                        let _genre = item["genres"] as? [[String:Any]],
                        let _releaseDate = item["releaseDate"] as? String,
                        let _url = item["url"] as? String,
                        let _copyright = item["copyright"] as? String {
                        
                        var genre = ""
                        for __genre in _genre {
                            if let _genreName = __genre["name"] {
                                genre.append("\(_genreName), ")
                            }
                        }
                        if genre.hasSuffix(", ") {
                            genre.removeLast(2)
                        }
                        
                        _album.albumName = _name
                        _album.artistName = _artistName
                        _album.thumbnail = _artworkUrl100
                        _album.genre = genre
                        _album.releaseDate = _releaseDate
                        _album.iTunesLink = _url
                        _album.copyrightInfo = _copyright
                    }
                    
                    
                    albums.append(_album)
                }
            }
            
            
        }
        return albums
    }
}
