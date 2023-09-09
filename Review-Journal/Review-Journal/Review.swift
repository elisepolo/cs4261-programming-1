//
//  Review.swift
//  Review-Journal
//
//  Created by Elise Polo on 9/6/23.
//

import Foundation

class Review {
    var title: String
    var body: String
    var lastUpdated: Date
    
    init(title: String, body: String, lastUpdated: Date) {
        self.title = title
        self.body = body
        self.lastUpdated = lastUpdated
    }
}
