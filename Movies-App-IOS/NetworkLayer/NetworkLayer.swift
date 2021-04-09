//
//  NetworkLayer.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 08/04/2021.
//

import Foundation
import Alamofire

typealias Handler = (_ response:Any? ,_ error:String? ,_ isSuccess:Bool?) -> Void
class NetworkLayer{
    
    
    class func request<T: Codable>(auth:String? = nil, path : String ,pageNumber:Int? = nil,method:Alamofire.HTTPMethod, params: [String : Any]? = nil ,headers : HTTPHeaders? = nil,encoding : ParameterEncoding = URLEncoding.queryString  ,model: T.Type, isURLEncoding:Bool = false ,useGenericBaseModel:Bool?=true,showLoading:Bool? = true,completionHandler: @escaping Handler)  {
        if showLoading ?? true{
            
            Hud.showLoading()
        }
        if !CheckNetwork.isConnectedToNetwork() {
            Hud.hideLoading()
            Alert.show(message: "No Internet Connection")
            return
        }
        let fullPath = Constants.baseURLMovies + path
        print("fullpath \(fullPath)")
        
        var fullParams  = ["api_key":Constants.APIKey]
        if pageNumber != nil{
            fullParams["page"] = "\(pageNumber ?? 0)"
        }
        var fullHeaders : [String:String] = [:]
        if let headers = headers {
            fullHeaders = headers
        }
        fullHeaders["Content-Type"] = "application/json"
        fullHeaders["Accept"] = "application/json"

        print("path -> \(fullPath)")
        print("headers -> \(fullHeaders)")
        print("body -> " , fullParams )
        // request
        print("Used encoding: ",encoding)

        
        Alamofire.request(fullPath, method: method ,parameters: fullParams, encoding:encoding, headers: fullHeaders).response { (response) in
            
//
        let decoder = JSONDecoder()
            Hud.hideLoading()
            print("code: ", response.response?.statusCode)
            if useGenericBaseModel ?? true{
                if response.response?.statusCode == 200{
                       do{
                           let data = try decoder.decode(BaseModel<T>.self, from: response.data! )
                           completionHandler(data,"",true)
                       }catch{
                           completionHandler(nil,"",false)
                       }
                }else{
                   Alert.show(message: "An error occurred")

                }
            }else{
                if response.response?.statusCode == 200{
                       do{
                        let data = try decoder.decode(T.self, from: response.data! )
                           completionHandler(data,"",true)
                       }catch{
                           completionHandler(nil,"",false)
                       }
                }else{
                   Alert.show(message: "An error occurred")

                }
            }
            
         
                
            
            // not conneted with server handle error
            if (response.error != nil) && response.response?.statusCode == nil {
                completionHandler(nil, response.error?.localizedDescription, false)
                Hud.hideLoading()
                Alert.show(message: response.error?.localizedDescription ?? "")
                
                return
            }
            

           
        }
    }
}
