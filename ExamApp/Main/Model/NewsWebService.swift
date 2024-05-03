//
//  NewsWebService.swift
//  TableView
//
//  Created by STTL on 01/05/24.
//

import Foundation

class NewsWebService: NSObject {
    
    //Get employeeList in Dictionary Datatype
    func getNewsList(block : ([NewsModel]) -> Swift.Void){
        var responsemodel =  [NewsModel]()
        let dict = readJsonFile(ofName: "newsList")
        if let arr = dict["NewsList"] as? [[String : Any]]{
            responsemodel =  arr.map({ NewsModel(fromDictionary: $0)})
        }
        block(responsemodel)
    }
    
    //Read Data from Json FIle
    func readJsonFile(ofName: String) -> [String : Any] {
        guard let strPath = Bundle.main.path(forResource: ofName, ofType: ".json") else {
            return [:]
        }
        do {
          
            let data = try Data(contentsOf: URL(fileURLWithPath: strPath), options: .alwaysMapped)
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let dictJson = jsonResult as? [String : Any] {
                return dictJson
            }
        } catch {
            print("Error!! Unable to parse ")
        }
        return [:]
    }
}
