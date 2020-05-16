//
//  ApiRouter.swift
//  oxfordCaps
//
//  Created by Ankit  Chaudhary on 26/03/19.
//  Copyright © 2019 Ankit  Chaudhary. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    enum ParameterType { case url, params, slashUrl }
    
    case dashboard(String)
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        var urlComponents = URLComponents.init(string: url.absoluteString)
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(NetworkConstants.ContentType.trustkeyValue.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.trustkey.rawValue)
        urlRequest.setValue(NetworkConstants.ContentType.platformValue.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.platform.rawValue)
        urlRequest.setValue(NetworkConstants.ContentType.versionValue.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.version.rawValue)
        urlRequest.setValue(UIDevice.current.identifierForVendor?.description ?? "", forHTTPHeaderField: NetworkConstants.HttpHeaderField.deviceId.rawValue)
        
        if UserDefaults.standard.value(forKey: "tokenResponse") != nil {
            let tokenValue = UserDefaults.standard.value(forKey: "tokenResponse")            
            urlRequest.setValue((tokenValue as! String).getToken(), forHTTPHeaderField: NetworkConstants.HttpHeaderField.Authorization.rawValue)
        }
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        if parameters?.1 == .params {
            return try encoding.encode(urlRequest, with: parameters?.0)
        }
        
        if parameters?.1 == .slashUrl {
            urlRequest.url = URL.init(string: (urlRequest.url?.absoluteString ?? "") + (parameters?.0?.first?.value as? String ?? ""))
        } else {
            let urlParams = parameters?.0?.reduce("", { (finalString, dict) -> String in
                var result = finalString
                result += (result.isEmpty ? "?" : "&") + (dict.key + "=" + (dict.value as? String ?? (dict.value as! Int).description))
                return result
            })
            urlRequest.url = URL.init(string: (urlRequest.url?.absoluteString ?? "") + (urlParams ?? ""))!
        }
        
        return try encoding.encode(urlRequest, with: nil)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .dashboard(_):
            return .get
        }
        
    }
    
    //MARK: - Path
    private var path: String {
        switch self {
        case .dashboard(_):
            return "dashboard"
        }
    }
} 

extension String {
    func getToken() -> String {
        return "Bearer \(self)"
    }
}
