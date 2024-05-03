//
//  NewsModel.swift
//  TableView
//
//  Created by STTL on 01/05/24.
//

import Foundation

class NewsModel: NSObject {
    
    var id: Int!
    var headline: String!
    var category: String!
    var date: String!
    var time: String!
    var readingTime:String!
    var imgUrl : String!
    var blog : String!
    var author : String!
    var photoCredit : String!
    var isBookmark : Bool!
    
    init(fromDictionary dictionary: [String: Any]) {
        id = dictionary["id"] as? Int
        headline = dictionary["headline"] as? String
        category = dictionary["category"] as? String
        date = dictionary["date"] as? String
        time = dictionary["time"] as? String
        readingTime = dictionary["readingTime"] as? String
        imgUrl = dictionary["imgUrl"] as? String
        blog = dictionary["blog"] as? String
        author = dictionary["author"] as? String
        photoCredit = dictionary["photoCredit"] as? String
        isBookmark = dictionary["isBookmark"] as? Bool
    }
}

