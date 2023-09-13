//
//  ReviewDatabase.swift
//  Review-Journal
//
//  Created by Elise Polo on 9/8/23.
//

import Foundation
import FirebaseCore
import FirebaseDatabase




class ReviewDatabase {
    private var reviews: [Review] = []
    var ref: DatabaseReference!
    weak var delegate: UpdateDelegate?
    
    init() {
        ref = Database.database().reference()
        
        ref.child("Reviews").getData(completion:  { [self] error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            for child in snapshot?.children.allObjects as! [DataSnapshot] {
                let dict = child.value as? [String: AnyObject] ?? [:]
                saveNew(review: Review(title: dict["title"] as! String, body: dict["body"] as! String, lastUpdated: Date()))
            }
            
            // Now that data is loaded, you can perform any UI updates or additional setup here.
            // For example, you can reload a table view or collection view if you're using one.
            synchronize()
            self.delegate?.didUpdate(sender: self)
            //saveNew(review: Review(title: "Hi", body: "Bye", date: Date()))
        })
        
    }

    
    var countReviews: Int {
        return reviews.count
    }
    
    func review(atIndex index: Int) -> Review {
        return reviews[index]
    }
    
    func saveNew(review: Review) {
        reviews.append(review)
        self.ref.child("Reviews").child(String(countReviews)).setValue(["title" : review.title, "body": review.body])
        synchronize()
    }
    
    func update(review: Review) {
        if let index = reviews.firstIndex(where: { $0.title == review.title }) {
            reviews[index] = review
            synchronize()
        }
    }
    
    private func synchronize() {
        reviews.sort(by: { $0.lastUpdated > $1.lastUpdated })
    }
    
    

}
protocol UpdateDelegate : class {
    func didUpdate(sender: ReviewDatabase)
}
