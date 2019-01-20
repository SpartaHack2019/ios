//
//  PostSubmitViewController.swift
//  Zooper-iOS
//
//  Created by Austin Evans on 1/19/19.
//  Copyright © 2019 Austin Evans. All rights reserved.
//

import UIKit

class PostSubmitViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardToTopContraint: NSLayoutConstraint!

    var placeholderText = "Tell us about your furry friend..."
    var newImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.delegate = self

        descriptionTextView.text = placeholderText
        descriptionTextView.textColor = UIColor.lightGray

        imageView.image = newImage

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
    }

    @IBAction func handleTap(_ sender: Any) {
        descriptionTextView.resignFirstResponder()
    }
    @IBAction func postButtonPressed(_ sender: Any) {
        tabBarController?.selectedIndex = 2
        navigationController?.popToRootViewController(animated: true)

    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0.01176470588, green: 0.3411764706, blue: 0.5137254902, alpha: 1)
        }
        cardToTopContraint.constant = -100
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text == "" {
            descriptionTextView.text = placeholderText
            descriptionTextView.textColor = UIColor.lightGray
        }
        cardToTopContraint.constant = 36.5
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descriptionTextView.resignFirstResponder()
            return false
        }
        return true
    }
}
