//
//  PersonCell.swift
//  MissingPersons
//
//  Created by Kacper Kowalski on 11.10.2016.
//  Copyright © 2016 Kacper Kowalski. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    @IBOutlet weak var personImage:UIImageView!
    
    func configureCell(imgUrl: String) {
        
        if let url = URL(string: imgUrl) {
            downloadImage(url: url)
        }
}
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { (data, response, error) in
            // getting the main thread
            DispatchQueue.main.sync {
                guard let data = data , error == nil else { return }
                
                // if theres data and no error, show data as let
                // if theres and error, or nil -> we will return -> safe guard nothing happens
                
                self.personImage.image = UIImage(data: data)
            }
            
            
        }
        
        
    }
    
    // completion handler, we want this to be called after the url search
    
    func getDataFromUrl(url: URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _
        error: Error?) -> Void)) {
    
    // creating a get request - hit the url, grab data, when data is downloaded it;s gonna call this closure
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            completion(data, response, error)
        
        
    }.resume()
    
    
}
    
}
