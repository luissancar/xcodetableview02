//
//  HomeModel.swift
//  xcodemysql
//
//  Created by Luis José Sánchez Carrasco on 2/1/18.
//  Copyright © 2018 Luis José Sánchez Carrasco. All rights reserved.
//

import Foundation


protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    let urlPath = "http://iesayala.ddns.net/xcode/select.php"     
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        print("sssssss")
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let cod = jsonElement["cod"] as? String,
                let cosa = jsonElement["cosa"] as? String            {
                
                location.cod = cod
                location.cosa = cosa
                print("bbbbbb")
                
            }
            print("hhhhhh")
            
            locations.add(location)
            
        }
        print("rrrrrrr")
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: locations)
            
        })
    }
}
