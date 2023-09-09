//
//  ReviewViewController.swift
//  Review-Journal
//
//  Created by Elise Polo on 9/6/23.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var review: Review?
    
    var updateNotification: ((Review) -> Void)?
    
    var saveNotification: ((Review) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func save() {
        let newTitle = self.titleTextField.text ?? "New Note"
        let newBody = self.bodyTextView.text ?? ""
        if let review = self.review {
            review.title = newTitle
            review.body = newBody
            review.lastUpdated = Date()
            self.updateNotification?(review)
        } else {
            let newReview = Review(title: newTitle, body: newBody, lastUpdated: Date())
            self.saveNotification?(newReview)
        }
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        if let review = self.review {
            self.title = review.title
            self.titleTextField.text = review.title
            self.bodyTextView.text = review.body
        } else {
            self.title = "New Review"
            self.titleTextField.text = "New Review"
            self.bodyTextView.text = nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
