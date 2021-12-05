//
//  ListingsAPI.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation

import RxSwift
import RxCocoa
import Alamofire


//https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer

typealias JSONObject = [String: Any]

protocol ListingsAPIProtocol {
    static func getListing() -> Observable<AdsListing>
}


protocol AddressProtocol {
    func getBaseUrlString() -> String
    func getUrl() -> URL
}

struct ListingsAPI: ListingsAPIProtocol {
    
    // MARK: - API Addresses
    enum Address: String , AddressProtocol{
        func getBaseUrlString() -> String {
            return "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/"
        }
        func getUrl() -> URL {
            return URL(string: getBaseUrlString().appending(rawValue))!
        }
        case adsListings = "default/dynamodb-writer"
        
    }
    
    // MARK: - API errors
    enum Errors: Error {
        case requestFailed
        case parsingFailed
    }
    
    // MARK: - API Endpoint Requests
    
    static func getListing() -> Observable<AdsListing> {
        
        let response: Observable<AdsListing> = request(
            address: ListingsAPI.Address.adsListings)
        
        return response
        //will do the mapping in the viewmodel
        //        .map { listing in
        //            guard let ads = listing.results as? AdsListing else {return []}
        //          return ads
        //      }
    }
    
    // MARK: - generic request to send an SLRequest
    static func request<T: Decodable>(address: AddressProtocol, parameters: [String: String] = [:]) -> Observable<T> {
        return Observable.create { observer in
            let comps = URLComponents(string: address.getUrl().absoluteString)!
            //comps.queryItems = parameters.sorted{ $0.0 < $1.0 }.map(URLQueryItem.init)
            let url = try! comps.asURL()
            
            
            let request =  AF.request(url.absoluteString)
            
            //        let request = AF.request(url.absoluteString,
            //                                 method: .get,
            //                   parameters: nil,
            //                   encoding: URLEncoding.httpBody,
            //                   headers: nil,
            //                   interceptor: nil,
            //                   requestModifier: nil)
            
            request.responseJSON { response in
                guard response.error == nil, let data = response.data  else { // , let result = json else {
                    observer.onError(Errors.requestFailed)
                    return
                }
                
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    //let json = try JSONSerialization.jsonObject(with: data, options: []) as! T
                    observer.onNext(json)
                    observer.onCompleted()
                }
                catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    observer.onError(Errors.parsingFailed)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    observer.onError(Errors.parsingFailed)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    observer.onError(Errors.parsingFailed)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    observer.onError(Errors.parsingFailed)
                } catch {
                    print("error: ", error)
                    observer.onError(Errors.parsingFailed)
                }
               
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

extension String {
    var safeFileNameRepresentation: String {
        return replacingOccurrences(of: "?", with: "-")
            .replacingOccurrences(of: "&", with: "-")
            .replacingOccurrences(of: "=", with: "-")
    }
}

extension URL {
    var safeLocalRepresentation: URL {
        return URL(string: absoluteString.safeFileNameRepresentation)!
    }
}
