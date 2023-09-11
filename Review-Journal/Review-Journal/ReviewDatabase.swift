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
    
    init() {
        ref = Database.database().reference()
        ref.child("Reviews").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            let reviews = snapshot?.value
            print(reviews)
        });
        
        
        saveNew(review: Review(title: "First", body: "First Test Note", lastUpdated: Date()))
        self.ref.child("Reviews").child("1").setValue(["title" : "First", "body": "First Test Note"])
        saveNew(review: Review(title: "Second", body: "Second Test Note", lastUpdated: Date()))
        self.ref.child("Reviews").child("2").setValue(["title" : "Second", "body": "Second Test Note"])
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
