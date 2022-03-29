//
//  APICaller.swift
//  NewsApp
//
//  Created by Skyler Muller on 3/29/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
    static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e8e28a0b3d3b47a8b5d915b283e874be")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
 }
//Models

struct APIResponse: Codable{
    let articles: [Article]
}

struct Article{
    let source: DispatchSource
    let title: String
    let description : String
    let url: String
    let urlToImage: String
    let publishedAt: String
}
struct DispatchSource: Codable{
    let name: String
}




