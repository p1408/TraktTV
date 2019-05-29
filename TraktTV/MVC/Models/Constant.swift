//
//  Constant.swift
//  TraktTV
//
//  Created by pedro cortez osorio on 5/26/19.
//  Copyright © 2019 gamestorming. All rights reserved.
//

import UIKit


internal struct URLs {
    
    static internal let baseURL = "https://api.trakt.tv/"
    static internal let code = "\(baseURL)oauth/device/code"
    //static internal let search = "\(baseURL)movies/popular?query=gua"
    static internal let getToken = "https://private-anon-7b37ff7384-trakt.apiary-mock.com/oauth/token"
    static internal let popularMovies = "\(baseURL)movies/popular"
    static internal let overviewMovies = "\(baseURL)movies"
}

class Constant: NSObject {
    static let clientID = "195c8df3e65856b84905a7c09632973c2c1881e6346b647b9be82aae549cf82b"
    static let clientSecret = "4aee5d09521c846c86d4afef1d163c7b9d2c2d70a8fd32db98fb89a3c15cd96b"
    static let pin = "D13F6199"
}
