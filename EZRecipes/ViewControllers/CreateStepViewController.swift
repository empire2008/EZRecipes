//
//  CreateStepViewController.swift
//  EZRecipes
//
//  Created by SpaCE_MAC on 16/9/2562 BE.
//  Copyright © 2562 SpaCE_MAC. All rights reserved.
//

import UIKit

class CreateStepViewController: UIViewController {

    @IBOutlet weak var stepDescription: UITextView!
    @IBOutlet weak var stepPhoto: UIImageView!
    
    var step = StepStructure()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = sourceType
        
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if stepDescription.text != nil{
            step.stepDescription = stepDescription.text
            let presenter = presentingViewController as! AddStepViewController
            presenter.steps.append(step)
            dismiss(animated: true, completion: nil)
        }
        else{
            emptyFieldAlertPopup()
        }
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
        let alert = UIAlertController(title: "Selection", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { (action) in
            // open camera
            self.imagePicker(sourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.imagePicker(sourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateStepViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        step.image = image?.pngData()
        stepPhoto.image = image
        dismiss(animated: true, completion: nil)
    }
}

extension CreateStepViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
