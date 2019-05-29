//
//  UserServiceProtocol.swift
//  TraktTV
//
//  Created by pedro cortez osorio on 5/26/19.
//  Copyright © 2019 gamestorming. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol UserServiceProtocol: BaseServiceProtocol {
    
}

extension UserServiceProtocol where Self: UserService {
    func code(clientID: String!,
              successResponse success: @escaping(_ response: JSON) -> Void,
              failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        //let fcm_token : String = UserDefaults.standard.object(forKey: "fcm_token") as! String
        let params = [
            "client_id": clientID
            ] as [String: AnyObject]
        cancelAllRequest()
        POST(toURL: URLs.code, params: params, accessToken: nil, success: success, failure: failure)
    }
    
    func auth(successResponse success: @escaping(_ response: JSON) -> Void,
              failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        let codeClient : String = UserDefaults.standard.object(forKey: "codeClient") as! String
        let params = [
                "code": codeClient,
                "client_id": Constant.clientID,
                "client_secret": Constant.clientSecret,
                "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
                "grant_type": "authorization_code"
            ] as [String: AnyObject]
        cancelAllRequest()
        POST(toURL: URLs.getToken, params: params, accessToken: nil, success: success, failure: failure)
    }
    
    func getPopularMovie(query: String, page: String, ssuccessResponse success: @escaping(_ response: JSON) -> Void,
    failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        let url : String = "\(URLs.popularMovies)?query=\(query)&page=\(page)"
        cancelAllRequest()
        GET(toURL: url, params: nil, accessToken: nil, success: success, failure: failure)
    }
    
    func getOverViewMovie(code: String, ssuccessResponse success: @escaping(_ response: JSON) -> Void,
                         failureResponse failure: @escaping(_ error: NSError) -> Void) -> Void {
        let url : String = "\(URLs.overviewMovies)/\(code)/translations/en"
        cancelAllRequest()
        GET(toURL: url, params: nil, accessToken: nil, success: success, failure: failure)
    }
    
    
}
