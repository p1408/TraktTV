//
//  Translator.swift
//  TraktTV
//
//  Created by pedro cortez osorio on 5/26/19.
//  Copyright © 2019 gamestorming. All rights reserved.
//

import UIKit
import SwiftyJSON

class Translator: NSObject {
    class func MovieTranslate(_ dict : JSON) -> Movie{
        
        let movie : Movie = Movie()
        movie.yearMovie = dict["year"].intValue
        movie.tittleMovie = dict["title"].stringValue
        movie.idMovie = DetailMovieTranslate(dict["ids"].dictionaryValue)
        
        return movie
    }
    class func DetailMovieTranslate(_ dict : [String: JSON]) -> DetailMovies{
        
        let detailMovie : DetailMovies = DetailMovies()
        detailMovie.trakt = dict["trakt"]?.intValue ?? 0
        detailMovie.tmdb = dict["tmdb"]?.intValue ?? 0
        detailMovie.slug = dict["slug"]?.stringValue ?? ""
        detailMovie.imdb = dict["imdb"]?.stringValue ?? ""
        
        return detailMovie
    }
//    class func MovieTranslate(_ dict : [String : Any]) -> Movie{
//
//        let movie : Movie = Movie()
//        movie.yearMovie = ((dict["year"] as? Int != nil) ? (dict["year"] as? Int) : Int(dict["year"] as? String ?? ""))!
//        movie.tittleMovie = dict["title"] as? String ?? ""
//
//        return movie
//    }
//    class func DetailMovieTranslate(_ dict : [String : Any]) -> DetailMovies{
//
//        let detailMovie : DetailMovies = DetailMovies()
//        detailMovie.trakt = ((dict["trakt"] as? Int != nil) ? (dict["trakt"] as? Int) : Int(dict["trakt"] as? String ?? ""))!
//        detailMovie.tmdb = ((dict["tmdb"] as? Int != nil) ? (dict["tmdb"] as? Int) : Int(dict["tmdb"] as? String ?? ""))!
//        detailMovie.slug = dict["slug"] as? String ?? ""
//        detailMovie.imdb = dict["imdb"] as? String ?? ""
//
//        return detailMovie
//    }
    
}
