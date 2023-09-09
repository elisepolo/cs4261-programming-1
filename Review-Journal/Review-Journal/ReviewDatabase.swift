//
//  ReviewDatabase.swift
//  Review-Journal
//
//  Created by Elise Polo on 9/8/23.
//

import Foundation

class ReviewDatabase {
    private var reviews: [Review] = []
    
    init() {
        saveNew(review: Review(title: "First", body: "First Test Note", lastUpdated: Date()))
        saveNew(review: Review(title: "Second", body: "Second Test Note", lastUpdated: Date()))
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
    
    private func synchronize() {
        reviews.sort(by: { $0.lastUpdated > $1.lastUpdated })
    }
}
