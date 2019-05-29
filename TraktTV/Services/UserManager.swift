//
//  UserManager.swift
//  TraktTV
//
//  Created by pedro cortez osorio on 5/26/19.
//  Copyright © 2019 gamestorming. All rights reserved.
//
import Foundation
import SwiftyJSON

class UserManager: NSObject {
    
    //MARK: - Singleton
    
    static let sharedManager = UserManager()
    
//    var currentUser: User? {
//        return realm.objects(User.self).first
//    }
    
    //MARK: - Public
    
    
    func code(clientID: String!,
               successResponse success: @escaping(_ message: String) -> Void,
               failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        UserService.sharedService.code(clientID: clientID, successResponse: { (response) in
            let dictionary = response.dictionaryValue
            
            print("User: \(response.dictionaryValue)")
            
            let code = dictionary["device_code"]?.stringValue ?? ""
            
            let dataDict:[String: String] = ["codeClient": code]
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(dataDict, forKey: "codeClient")
            _ = userDefaults.synchronize()
            success("Éxito")
        }) { (error) in
            failure(error)
        }
    }
    
    func getToken(successResponse success: @escaping(_ message: String) -> Void,
              failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        UserService.sharedService.auth( successResponse: { (response) in
            let dictionary = response.dictionaryValue
            
            print("User: \(response.dictionaryValue)")
            
            let code = dictionary["access_token"]?.stringValue ?? ""
            
            let dataDict:[String: String] = ["access_token": code]
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(dataDict, forKey: "access_token")
            _ = userDefaults.synchronize()
            success("Éxito")
        }) { (error) in
            failure(error)
        }
    }
    func popularMovies(query: String, page: String,
                       successResponse success: @escaping(_ movies: [Movie]) -> Void,
                       failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        UserService.sharedService.getPopularMovie(query: query, page: page, ssuccessResponse: { (response) in
            let dictionary = response.arrayValue
            var arrayMovie = [Movie]()
            for dict in dictionary{
                arrayMovie.append(Translator.MovieTranslate(dict))
            }
            
            success(arrayMovie)
        }) { (error) in
            failure(error)
        }
    }
    
    func overViewMoview(code: String,
                        successResponse success: @escaping(_ movies: String) -> Void,
                        failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        UserService.sharedService.getOverViewMovie(code: code, ssuccessResponse: { (response) in
            let dictionary = response.arrayValue
            var movie = dictionary.first
            let overview = movie?["overview"].stringValue ?? ""
            
            success(overview)
        }) { (error) in
            failure(error)
        }
    }
    
    
}
