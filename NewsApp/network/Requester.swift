//
//  Requester.swift
//  NewsApp
//
//  Created by Yuri Misyac on 06.02.2021.
//

import Foundation
import Alamofire

let API_KEY = "057dfb93fa5b4663a20b247cd749101d"

open class Requester {
    
    private static let endpoint = "http://newsapi.org/v2/top-headlines"
    
    static func getNews(country: String = "us") -> DataRequest {
        let params = [
            Param.country.rawValue : country,
            Param.apiKey.rawValue : API_KEY
        ]
        
        return AF.request(endpoint, parameters: params)
    }
    
}

struct Article: Decodable {
    let title: String
}

struct News: Decodable {
    let articles: [Article]
}

enum Param: String {
    case country = "country"
    case apiKey = "apiKey"
}
