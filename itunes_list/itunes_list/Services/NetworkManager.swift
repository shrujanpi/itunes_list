//
//  NetworkManager.swift
//  itunes_list
//
//  Created by __this__ on 10/22/19.
//  Copyright © 2019 __this__. All rights reserved.
//

import Foundation


struct NetworkManager {
    
    let fetchURL: URL?
    
    //Custom Init to accept the URL
    init (url: URL) {
        fetchURL = url
    }
    //Downloads the data
    //Returns the JSON Dictionary
    func getData(_ completion: @escaping ([String:AnyObject]) -> Void) {
        
        //Create configuration object
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        
        //Create session object with configuration
        let session: URLSession = URLSession(configuration:configuration)
        
        //Create request object with URL
        let request = URLRequest(url: fetchURL!)
        
        //Create data task
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            do {
                //Get json from Foundation Object
                let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                completion(jsonDict)
            }
            catch {
                print("json error: \(error)")
            }
            
        });
        task.resume()
    }
}

