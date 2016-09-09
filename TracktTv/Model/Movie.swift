//
//  Movie.swift
//  TracktTv
//
//  Created by Arturo Gamarra on 9/8/16.
//  Copyright © 2016 Trivago. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {

    // MARK: - Properties
    var title:String = ""
    var year:Int = 0
    var imdb:String = ""
    var tmdb:Int = 0
    var trakt:Int = 0
    var thumbImageURL:String = ""
    
    // MARK: - Public
    func copyFromJSON(json:JSON) {
        self.title = json["title"].stringValue
        self.year = json["year"].intValue
        self.tmdb = json["ids"]["tmdb"].intValue
        self.trakt = json["ids"]["trakt"].intValue
        self.imdb = json["ids"]["imdb"].stringValue
        self.thumbImageURL = json["images"]["poster"]["thumb"].stringValue
    }
    
    class func moviesFromJSONArray(jsonArray:[JSON]) -> [Movie] {
        var movies:[Movie] = []
        for json in jsonArray {
            let movie = Movie()
            movie.copyFromJSON(json)
            movies.append(movie)
        }
        return movies
    }
}
