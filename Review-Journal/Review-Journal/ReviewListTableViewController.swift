//
//  ReviewListTableViewController.swift
//  Review-Journal
//
//  Created by Elise Polo on 9/6/23.
//

import UIKit

class ReviewListTableViewController: UIViewController, UITableViewDataSource, UpdateDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewDatabase.countReviews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Review Cell", for: indexPath)
            let review = self.reviewDatabase.review(atIndex: indexPath.row)
            cell.textLabel?.text = review.title
            cell.detailTextLabel?.text = review.lastUpdated.description
            return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    private let reviewDatabase = ReviewDatabase();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.title = "Reviews"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newReview))
            self.navigationItem.rightBarButtonItem = addButton
        
        reviewDatabase.delegate = self;
    }
    
    func didUpdate(sender: ReviewDatabase) {
            self.tableView.reloadData()
        }
    
    @objc private func newReview() {
        self.performSegue(withIdentifier: "Review Segue", sender: nil)
    }
    
    private func update(review: Review) {
        reviewDatabase.update(review: review)
        tableView.reloadData()
    }
    
    private func saveNew(review: Review) {
        reviewDatabase.saveNew(review: review)
        tableView.reloadData()
    }


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let reviewVC = segue.destination as? ReviewViewController { // 1
            // Show existing note
        reviewVC.updateNotification = self.update
        reviewVC.saveNotification = self.saveNew
            if let selectedCell = sender as? UITableViewCell,
                let selectedIndex = tableView.indexPath(for: selectedCell) { // 2
                reviewVC.review = self.reviewDatabase.review(atIndex: selectedIndex.row) // 3
            }
        }
    }

}
