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

 
    @IBAction func checkForMatch(_ sender: AnyObject) {
        
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
        }
        dismiss(animated: true, completion: nil)
        
    }

    func loadPicker(gesture: UITapGestureRecognizer) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)  // present view controller
    }
    
    
}

