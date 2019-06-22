//
//  DataController.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 21.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import ObjectMapper


class DataController: NSObject, URLSessionDelegate {
    
    func getRequest<T : Mappable>(endpoint: String, parameters: [String : Any]?, completion: @escaping (_ response: T?,_ error: NSError?) -> Void) {
        var requestUrlString = "\(NetworkManager.sharedInstance.baseURL)\(endpoint)"
        if let parameters = parameters {
            let parameterString = parameters.stringFromHttpParameters()
            requestUrlString += "?\(parameterString)"
        }
        
        let urlRequest = self.createRequest(path: requestUrlString, parameters: parameters, httpMethod: "GET")
        self.openRequest(request: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) {
                    do {
                        if dataString == "" {
                            completion(BaseResponse() as? T, nil)
                        } else {
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if json is NSArray {
                                let jsonDictionary: [String : Any] = ["data" : json]
                                var response : T = Mapper<T>().map(JSONObject: jsonDictionary)!
                                completion(response, error as NSError?)
                            } else if json is NSDictionary {
                                let jsonDictionary: [String : Any] = json as! [String : Any]
                                let response : T = Mapper<T>().map(JSONObject: jsonDictionary)!
                                completion(response, error as NSError?)
                            } else if json is String {
                                let response : T = T(map: Map(mappingType: MappingType.fromJSON, JSON: ["":""]))!
                                completion(response, error as NSError?)
                            } else {
                                let response : T = Mapper<T>().map(JSONObject: json)!
                                completion(response, error as NSError?)
                            }
                        }
                    } catch let error {
                        completion(nil, error as NSError?)
                    }
                } else {
                    completion(nil, error as NSError?)
                }
            } else {
                completion(nil, error as NSError?)
            }
            }.resume()
    }
    
    private func createRequest(path: String, timeoutInterval: TimeInterval = 90, parameters: [String : Any]?, httpMethod: String) -> URLRequest {
        let requestURL = URL(string: path)
        var urlRequest = URLRequest.init(url: requestURL!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        urlRequest.httpMethod = httpMethod
        return urlRequest
    }
    
    private func openRequest(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        return task
    }
}

import Foundation

extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if value is String {
                let percentEscapedValue = (value as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                return "\(percentEscapedKey!)=\(percentEscapedValue!)"
            } else if value is NSDictionary {
                return (value as! Dictionary).stringFromHttpParameters()
            } else {
                return ""
            }
        }
        
        return parameterArray.joined(separator: "&")
    }
}
