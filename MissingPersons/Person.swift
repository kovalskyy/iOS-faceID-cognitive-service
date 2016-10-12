//
//  Person.swift
//  MissingPersons
//
//  Created by Kacper Kowalski on 11.10.2016.
//  Copyright © 2016 Kacper Kowalski. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class Person {
    
    var faceId: String?
    var personImage: UIImage?
    var personImageUrl: String?
    
    init(personImageUrL: String) {
        self.personImageUrl = personImageUrL
    }
    
    
    func downloadFaceId() { // pass the  image to cogintivie service API
        if let img = personImage, let imgData = UIImageJPEGRepresentation(img, 0.8) {   // convert and pass into the server
            
            FaceService.instance.client?.detect(with: imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: nil, completionBlock:
                { (faces: [MPOFace]?, err: Error?) in
            
                    if err == nil {
                        var faceId: String?
                        for face in faces! {
                            faceId = face.faceId
                            print("Face Id: \(faceId)")
                            break
                        }
                        
                        self.faceId = faceId  //When u download an image from server, it will instantly get faceId!
                    }
                    
        })
            
        }
        
    }
}
