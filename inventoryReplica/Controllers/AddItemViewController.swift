//
//  AddItemViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 12/07/23.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var minLevelTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var totalValue: UILabel!
    var delegate: AddItemsDelegate?
    
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        addBorder()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
    override open var shouldAutorotate: Bool {
            return false
        }
    
    @IBAction func addPhotoPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
}
    
    @IBAction func saveItemPressed(_ sender: UIBarButtonItem) {
        
        let newItem = Item(
            name: nameTextField.text!,
            quantity: Int(quantityTextField.text!) ?? 0,
            images: [],
            minLevel: Int(minLevelTextField.text!),
            price: Float(priceTextField.text!),
            totalValue: nil,
            notes: nil,
            tags: nil,
            sortlyId: ItemManager.createNewId(),
            createdAt: Date.now,
            updatedAt: Date.now
        )
        
        saveItem(newItem)
    }
    
    
    func saveItem(_ item : Item) {
        if let user = Auth.auth().currentUser?.email {
            db.collection(K.FStore.itemsCollectionName).addDocument(data: [
                "user": user,
                "name": item.name,
                "quantity": item.quantity,
                "minLevel": item.minLevel as Any,
                "price": item.price as Any,
                "notes": item.notes as Any,
                "tags": item.tags as Any,
                "sortlyId": item.sortlyId as Any,
                "createdAt": item.createdAt as Any,
                "updatedAt": item.updatedAt as Any
                
            ]) { error in
                if let error = error {
                    print(error)
                } else {
                    print("Successfully saved the data")
                }
            }
        }
       
    
        // Go back to the main view and update the data there.
        delegate?.didUpdateData()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func addBorder() {
        addPhotoButton.contentMode = .scaleAspectFill
        addPhotoButton.tintColor = .white
        
        let dashPattern: [NSNumber] = [4, 4] // Customize the pattern as desired
        let borderLayer = CAShapeLayer()
        
        
        borderLayer.strokeColor = addPhotoButton.layer.borderColor
        borderLayer.lineDashPattern = dashPattern
        borderLayer.frame = addPhotoButton.bounds
        borderLayer.fillColor = nil
        borderLayer.cornerRadius = 40
        borderLayer.path = UIBezierPath(roundedRect: addPhotoButton.bounds, cornerRadius: 10).cgPath

                
        // Add the border layer to the button
        addPhotoButton.layer.addSublayer(borderLayer)
        
        
        
    }
}


extension AddItemViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("info", info[.originalImage])
        if let image = info[.originalImage] as? UIImage {
            addPhotoButton.setBackgroundImage(image, for: .normal)
            
//            addPhotoButton.backgroundColor = UIColor(patternImage: image)
              }
        picker.dismiss(animated: true, completion: nil)
    }
}



protocol AddItemsDelegate {
    func didUpdateData()
}
