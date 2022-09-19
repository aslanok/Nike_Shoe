//
//  addPhotoViewController.swift
//  NikeApp
//
//  Created by MacBook on 16.09.2022.
//

import UIKit
import CoreData

class addPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var selectedItem : Entity? = nil 
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPhoto.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPic))

        imgPhoto.addGestureRecognizer(imageGestureRecognizer)
        //sadece en sondakine gesture ekliyordu
        if selectedItem == nil {
            //yeni photo eklenecek
            self.navigationItem.title = "Add a new product"
        } else {
            self.navigationItem.title = selectedItem?.brandtext
            brandTextField.text = selectedItem?.brandtext
            descriptionTextField.text = selectedItem?.descriptiontext
            priceTextField.text = "\(selectedItem?.price)"
            imgPhoto.image = UIImage(data: (selectedItem?.image as! Data ))
            
        }
        
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    
    
    @objc func selectPic(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgPhoto.image = info[.editedImage] as? UIImage
        
        self.dismiss(animated: true)
    }
     

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let shoe = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context)
        shoe.setValue(brandTextField.text, forKey: "brandtext")
        shoe.setValue(descriptionTextField.text, forKey: "descriptiontext")
        
        if let fiyat = Int(priceTextField.text!) {
            shoe.setValue(fiyat, forKey: "price")
        }
        
        shoe.setValue(UUID(), forKey: "id")
        
        let data = imgPhoto.image?.jpegData(compressionQuality: 0.5)
        shoe.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("kayıt başarılı")
        } catch {
            print("hata var ")
        }
        
        navigationController?.popViewController(animated: true)//bu satır sayesinde kullanıcı kayıt işleminden sonra anamenüye dönecek

    }
    
    
}
