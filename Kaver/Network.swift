//
//  Network.swift
//
//  Created by Maciej Matuszewski on 13.09.2016.
//  Copyright © 2016 Codeaddict. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import KeychainAccess
import Firebase

// Networking

enum Network {
    case Login(email: String, password: String)
    case GetMe()
    case GetProducts()
    
	//MARK:- Private
	private var method: HTTPMethod{
        
        return HTTPMethod.post
	}

	var url: String {
        return Constants.kServerURL + self.urlEnd
		
    }
    
    private var headers: HTTPHeaders{
        return [
            "Authorization": Configuration.getAuthorization() ?? "",
            "Accept": "application/json",
            "Accept-Language": "en".localized
        ]
    }
	
	private var urlEnd: String {
		switch self {
		case .Login: return "login"
        case .GetMe: return "getLoggedUser"
        case .GetProducts: return "search"
		}
	}
	
	private var parameters: Parameters {
		switch self {
        case .GetMe():
            return [
                "token": Configuration.getAuthorization() ?? "",
                "mail": Configuration.getUserMail() ?? ""
            ]
        case .Login(let email, let password):
            return [
                "mail": email,
                "password": password
            ]
        case .GetProducts:
            return [
                "token": Configuration.getAuthorization() ?? "",
                "mail": Configuration.getUserMail() ?? "",
                "name": "Test"
            ]
		}
	}
    
	//MARK:- public
	
	public func request(successCompletion: @escaping ([String: AnyObject]) -> Void, errorCompletion: ((String) -> Void)?) {
        "***START***\nRequest for JSON: \nurl:\(self.url)\nmethod:\(self.method)\nparameters:\(self.parameters)\n***END***".log()
        
		Alamofire
			.request(
				self.url,
				method: self.method,
				parameters: self.parameters,
				headers: self.headers)
			.validate()
			.responseJSON {
				(response) in
                
				switch response.result {
				case .success:
					successCompletion(response.result.value as? [String: AnyObject] ?? [:])
					
                case .failure(let error):
                    guard let function = errorCompletion
                    else{
                        return
                    }
					function(ErrorHandler.handleError(code: (error as! AFError).responseCode ?? 0))
				}
		}
	}
	
	func responseModel<T:Mappable>(successCompletion: @escaping (T) -> Void, errorCompletion: ((String) -> Void)?) {
        "***START***\nRequest for Model: \nurl:\(self.url)\nmethod:\(self.method)\nparameters:\(self.parameters)\n***END***".log()
		Alamofire
			.request(
				self.url,
				method: self.method,
				parameters: self.parameters,
				headers: self.headers)
			.validate()
			.responseObject {
				(response: DataResponse<T>) in
				switch response.result {
				case .success:
					
					guard let model = response.result.value else{
                        guard let function = errorCompletion
                            else{
                                return
                        }
						function(ErrorHandler.handleError(code: 900))
						return
					}
					
					successCompletion(model)
					
                case .failure(let error):
                    guard let function = errorCompletion
                        else{
                            return
                    }
                    function(ErrorHandler.handleError(code: (error as! AFError).responseCode ?? 0))
				}
		}
	}
    
    func responseModelArray<T:Mappable>(successCompletion: @escaping ([T]) -> Void, errorCompletion: ((String) -> Void)?) {
        
        "***START***\nRequest for Model Array: \nurl:\(self.url)\nmethod:\(self.method)\nparameters:\(self.parameters)\n***END***".log()
        
        Alamofire
            .request(
                self.url,
                method: self.method,
                parameters: self.parameters,
                headers: self.headers)
            .validate()
            .responseArray {
                (response: DataResponse<[T]>) in
                switch response.result {
                case .success:
                    
                    guard let model = response.result.value else{
                        guard let function = errorCompletion
                            else{
                                return
                        }
                        function(ErrorHandler.handleError(code: 900))
                        return
                    }
                    
                    successCompletion(model)
                    
                case .failure(let error):
                    guard let function = errorCompletion
                        else{
                            return
                    }
                    function(ErrorHandler.handleError(code: (error as! AFError).responseCode ?? 0))
                }
        }
    }
}
