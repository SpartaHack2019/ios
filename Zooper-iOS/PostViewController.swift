//
//  PostViewController.swift
//  
//
//  Created by Austin Evans on 1/19/19.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Comfortaa", size: 30)!]
    }

    @IBAction func photoLibraryTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }

    @IBAction func cameraTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
    }
}
