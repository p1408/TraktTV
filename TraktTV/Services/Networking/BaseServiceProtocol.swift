//
//  BaseServiceProtocol.swift
//  TraktTV
//
//  Created by pedro cortez osorio on 5/26/19.
//  Copyright © 2019 gamestorming. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

typealias SuccessResponse = (_ response: JSON) -> Void
typealias FailureResponse = (_ error: NSError) -> Void

//let baseURL = "https://redvet.ctrl.pe/api/v1/" //-->URL<--


//También cambiar la url en los archivos User.swift(en una linea), ProfileViewController.swift (en dos lineas distintas)
//var headers = ["X-Access-Token":""]
var headers = ["Content-Type": "Application/json", "trakt-api-key": Constant.clientID, "trakt-api-version": "2"]

protocol BaseServiceProtocol {
    
    // MARK: - Public
    
    func validateResponse(_ statusCode: Int, response: JSON,success: SuccessResponse, failure: FailureResponse) -> Void
    
    func queryString(fromArray array: [String]?) -> String
    
    func GET(toURL url: String!, params: [String: AnyObject]?, accessToken: String?, success: @escaping SuccessResponse, failure: @escaping FailureResponse) -> Void
    
    func POST(toURL url: String!, params: [String: AnyObject]?, accessToken: String?, success: @escaping SuccessResponse, failure: @escaping FailureResponse) -> Void
    
    func getErrorMessage(msg: String) -> String
    
}

extension BaseServiceProtocol {
    
    // MARK: - Private
    
    func validateResponse(_ statusCode: Int, response: JSON,success: SuccessResponse, failure: FailureResponse) -> Void {
        
        let isSuccess = statusCode == 200 || statusCode == 201 || statusCode == 204 ? true : false
        
        if isSuccess{
            print(response)
            success(response)
        } else {
            let errorMessage = response.dictionary!["message"]?.stringValue ?? ""
            
            let error = NSError(domain: "TraktTV", code: -999, message: getErrorMessage(msg: errorMessage))
            failure(error)
        }
    }
    
    // MARK: - Public
    
    func queryString(fromArray array: [String]?) -> String {
        guard let v = array else {
            return ""
        }
        var s = ""
        for i in 0 ..< v.count {
            if i > 0 && i < v.count {
                s.append(",")
            }
            s.append(v[i].addingPercentEncoding(withAllowedCharacters: CharacterSet.init(charactersIn: "-_.!~*'()"))!)
        }
        return s
    }
    
    func getErrorMessage(msg: String) -> String {
        var errorMessage = msg
        switch errorMessage {
        case "Could not connect to the server.":
            errorMessage = "No se pudo conectar al servidor."
        case "The Internet connection appears to be offline.":
            errorMessage = "No hay conexión a internet."
        case "The operation couldn’t be completed. Software caused connection abort.":
            errorMessage = "La operación no pudo ser completada. Vuelve a intentarlo."
        case "The request timed out.":
            errorMessage = "El servidor no responde."
        default:
            break
        }
        return errorMessage
    }
    
    func cancelAllRequest(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
    
    func GET(toURL url: String!, params: [String: AnyObject]?, accessToken: String?, success: @escaping SuccessResponse, failure: @escaping FailureResponse) -> Void {
        
        print("🔗 URL GET-> \(url)")
        if accessToken != nil{
            headers.updateValue("Bearer \(accessToken!)", forKey: "Authorization")
        }
        
        Alamofire.request(url, method: .get, parameters: params, headers: headers).responseJSON
            { (response) in
                
                print("Success: \(response.result.isSuccess)")
                
                switch response.result {
                case .success:
                    let json = try! JSON(data: response.data!)
                    self.validateResponse((response.response?.statusCode)!, response: json, success: success, failure: failure)
                    break
                case .failure(let error):
                    let nsError = NSError(domain: "TraktTV", code: -999, message: self.getErrorMessage(msg: error.localizedDescription))
                    print(error.localizedDescription)
                    failure(nsError)
                    break
                }
        }
    }
    
    func POST(toURL url: String!, params: [String: AnyObject]?, accessToken: String?, success: @escaping SuccessResponse, failure: @escaping FailureResponse) -> Void {
        
        print("🔗 URL POST-> \(url)")
        
        if accessToken != nil{
            headers.updateValue("Bearer \(accessToken!)", forKey: "Authorization")
        }
        
        Alamofire.request(url, method: .post, parameters: params, headers: headers).responseJSON { (response) in
            
            print("Success: \(response.result.isSuccess)")
            
            let data = response.data!
            
            switch response.result {
            case .success:
                let json = try! JSON(data: data)
                self.validateResponse((response.response?.statusCode)!, response: json, success: success, failure: failure)
                break
            case .failure(let error):
                let nsError = NSError(domain: "TraktTV", code: -999, message: self.getErrorMessage(msg: error.localizedDescription))
                print(error.localizedDescription)
                failure(nsError)
                break
            }
        }
    }
    
    func PATCH(toURL url: String!, params: [String: AnyObject]?, accessToken: String?, success: @escaping SuccessResponse, failure: @escaping FailureResponse) -> Void {
        
        //let url = "\(baseURL)\(endpoint!)"
        print("🔗 URL PATCH-> \(url)")
        
        if accessToken != nil{
            headers.updateValue("Bearer \(accessToken!)", forKey: "Authorization")
        }
        
        Alamofire.request(url, method: .patch, parameters: params, headers: headers).responseJSON { (response) in
            
            print("Success: \(response.result.isSuccess)")
            
            let data = response.data!
            
            switch response.result {
            case .success:
                let json = try! JSON(data: data)
                self.validateResponse((response.response?.statusCode)!, response: json, success: success, failure: failure)
                break
            case .failure(let error):
                let nsError = NSError(domain: "TraktTV", code: -999, message: self.getErrorMessage(msg: error.localizedDescription))
                print(error.localizedDescription)
                failure(nsError)
                break
            }
        }
    }
}
