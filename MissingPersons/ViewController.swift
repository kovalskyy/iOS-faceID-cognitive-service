//
//  ViewController.swift
//  MissingPersons
//
//  Created by Kacper Kowalski on 10.10.2016.
//  Copyright © 2016 Kacper Kowalski. All rights reserved.
//

import UIKit
import ProjectOxfordFace

let baseURL = "http://localHost:6069/img/"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                        UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    var selectedPerson: Person?
    var hasSelectedImage: Bool = false

    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    //let missingPeople = [
    //    "person1.jpg",
    //    "person2.jpg",
    //    "person3.jpg",
    //    "person4.jpg",
    //    "person5.jpg",
    //    "person6.png"
    
    
    
    let missingPeople = [
        Person(personImageUrL: "person1.jpg"),
        Person(personImageUrL: "person2.jpg"),
        Person(personImageUrL: "person3.jpg"),
        Person(personImageUrL: "person4.jpg"),
        Person(personImageUrL: "person5.jpg"),
        Person(personImageUrL: "person6.png")
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(loadPicker(gesture:)))
        tap.numberOfTapsRequired = 1
        selectedImage.addGestureRecognizer(tap)
        
    }

 
    
        
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missingPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        
        let person = missingPeople[indexPath.row]
        cell.configureCell(person: person)
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedPerson = missingPeople[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! PersonCell
        
        cell.configureCell(person: selectedPerson!)
        cell.setSelected()
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage.image = pickedImage
            hasSelectedImage = true
        }
        dismiss(animated: true, completion: nil)
        
    }

    func loadPicker(gesture: UITapGestureRecognizer) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)  // present view controller
    }
    
    
    func showErrorAlert() {
        
            let alert = UIAlertController(title: "Selected Person & Image", message: "Please select a missing person to check and an image from library", preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func checkMatch(sender: AnyObject) {
        if selectedPerson == nil || !hasSelectedImage {
            showErrorAlert()
        } else {
            if let myImg = selectedImage.image, let imgData = UIImageJPEGRepresentation(myImg, 0.8) {
                
                // Doing now parsing with Microsoft API
                
                FaceService.instance.client?.detect(with: imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: nil, completionBlock: { (faces: [MPOFace]?, err: Error?) in
                    
                    if err == nil {
                        var faceId: String?
                        for face in faces! {
                            faceId = face.faceId
                            break
                        }
                        
                        if faceId != nil {
                            FaceService.instance.client?.verify(withFirstFaceId: self.selectedPerson?.faceId, faceId2: faceId, completionBlock: { (result: MPOVerifyResult?, err: Error?) in
                                
                                                                // Check for results!!!
                                
                                if err == nil {
                                    print(result?.confidence)
                                    print(result?.isIdentical)
                                    print(result.debugDescription)
                                } else {
                                    print(err.debugDescription)
                                }
                                
                                
                                
                            })
                        }
                    }
                })
            }
        }
       
     
                
            
        }
        
    }
    


