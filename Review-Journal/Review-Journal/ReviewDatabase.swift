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
        saveNew(review: Review(title: "First", body: "First Test Note", lastUpdated: Date()))
        self.ref.child("Reviews").child("3").setValue(["body": "username"])
        saveNew(review: Review(title: "Second", body: "Second Test Note", lastUpdated: Date()))
        self.ref.child("Reviews").child("4").setValue(["body": "username2"])
    }
    
    var countReviews: Int {
        return reviews.count
    }
    
    func review(atIndex index: Int) -> Review {
        return reviews[index]
    }
    
    func saveNew(review: Review) {
        reviews.append(review)
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
