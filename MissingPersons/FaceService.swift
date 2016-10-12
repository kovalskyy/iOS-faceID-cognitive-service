//
//  FaceService.swift
//  MissingPersons
//
//  Created by Kacper Kowalski on 11.10.2016.
//  Copyright © 2016 Kacper Kowalski. All rights reserved.
//

import Foundation
import ProjectOxfordFace

class FaceService { //create a singleton
    static let instance = FaceService()
    
    let client = MPOFaceServiceClient(subscriptionKey: "7dc8dffb5427447cbb73c3076754fe23")
    
}
