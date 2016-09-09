//
//  MovieService.swift
//  TracktTv
//
//  Created by Arturo Gamarra on 9/9/16.
//  Copyright © 2016 Trivago. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

enum MovieExtendService:String {
    case images
    case full
    case both = "images,full"
    
    func queryString() -> String {
        return "extended=\(self.rawValue)"
    }
    
}

class MovieService: NSObject {
    
    typealias SuccessServiceResponse = (response: JSON) -> Void
    typealias FailureServiceResponse = (error: NSError) -> Void
    
    // MARK: - Properties
    static let apiKey:String = "ad005b8c117cdeee58a1bdb7089ea31386cd489b21e14b19818c91511f12a086"
    private let baseURL = "https://api.trakt.tv/"
    private var currentRequest:Request?
    
    static let sharedService:MovieService = MovieService()
    
    // MARK: - Private
    private func GET(url:String, params: [String:AnyObject]?, success: SuccessServiceResponse, failure: FailureServiceResponse) -> Void {
        var headers: [String: String] = [:]
        headers["trakt-api-version"] = "2"
        headers["trakt-api-key"] = MovieService.apiKey

        self.currentRequest = Alamofire.request(.GET, url, parameters: params, encoding: .URL, headers: headers).responseJSON { response in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                success(response: json)
                
            case .Failure(let error):
                failure(error: error)
            }
        }
    }
    
    // MARK: - Public
    func loadPopularMoviesAtPage(page:Int, ofSize pageSize:Int, withSuccess success:(movies:[Movie]) -> Void, withFailure failure:(error:NSError) -> Void) {
        let url = "\(self.baseURL)/movies/popular?\(MovieExtendService.images.queryString())&page=\(page)&limit=\(pageSize)"
        self.GET(url, params: nil
            , success: { (response:JSON) in
                let movies = Movie.moviesFromJSONArray(response.arrayValue)
                success(movies: movies)
            }
            , failure: failure)
    }
    
    func searchMoviesWithText(text:String, atPage page:Int, ofSize pageSize:Int, withSuccess success:(movies:[Movie]) -> Void, withFailure failure:(error:NSError) -> Void) {
        if let request = self.currentRequest {
            request.cancel()
        }
        let url = "\(self.baseURL)/search/movie?\(MovieExtendService.both.queryString())&page=\(page)&limit=\(pageSize)&query=\(text)"
        self.GET(url, params: nil
            , success: { (response:JSON) in
                var movies:[Movie] = []
                for json in response.arrayValue {
                    let movie = Movie()
                    movie.copySearchFromJSON(json)
                    movies.append(movie)
                }
                success(movies: movies)
            }
            , failure: failure)
    }
    
}
