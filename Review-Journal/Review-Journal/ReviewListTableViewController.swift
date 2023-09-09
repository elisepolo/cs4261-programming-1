//
//  ReviewListTableViewController.swift
//  Review-Journal
//
//  Created by Elise Polo on 9/6/23.
//

import UIKit

class ReviewListTableViewController: UIViewController, UITableViewDataSource {
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
    private let reviewDatabase = ReviewDatabase()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.title = "Reviews"
        
        
    }
    



override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let reviewVC = segue.destination as? ReviewViewController { // 1
            // Show existing note
            if let selectedCell = sender as? UITableViewCell,
                let selectedIndex = tableView.indexPath(for: selectedCell) { // 2
                reviewVC.review = self.reviewDatabase.review(atIndex: selectedIndex.row) // 3
            }
        }
    }

}
