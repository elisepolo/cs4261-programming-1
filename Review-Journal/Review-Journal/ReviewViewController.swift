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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
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
