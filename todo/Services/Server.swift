//
//  Server.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//


import Foundation;


enum RequestMethod: String {
    case get = "GET";
    case post = "POST";
}


enum ServerError: Error {
    case unknown(Int);
    case httpResponse;
    case emptyResponse;
    case wrongReponse;
}


extension ServerError: CustomStringConvertible {
    var description: String {
        switch self {
        case .httpResponse:
            return "Received not HTTP response from server";
        case .wrongReponse:
            return "Wrong response from server";
        case .emptyResponse:
            return "Empty response from server";
        case .unknown(let code):
            return "Unknown error: \(code)";
        }
    }
}


extension ServerError: LocalizedError {
    var errorDescription: String? {
        String(localized: self.description);
    }
}


struct ServerHTTPError: Error {
    let code: Int;
}


extension ServerHTTPError: CustomStringConvertible {
    var description: String {
        HTTPURLResponse.localizedString(forStatusCode: self.code);
    }
}


extension ServerHTTPError: LocalizedError {
    var errorDescription: String? {
        self.description;
    }
}


extension HTTPURLResponse {
    var HTTPError: ServerHTTPError {
        .init(code: self.statusCode);
    }
}


struct TodoResponce: Decodable {
    let todos: [Todo];
}


protocol ServerProtocol: AnyObject {
    func get<T:Decodable>(path: String, type: T.Type, completionHandler: @escaping (Result<T,Error>) -> Void);
}


final class Server: ServerProtocol {
    
    struct Path {
        static let todos = "todos";
    }
    
    static let shared: ServerProtocol = Server();
    
    let url: URL! = URL(string: "https://dummyjson.com");
    let timeoutInterval: TimeInterval = 5;
    

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default;
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData;
        configuration.timeoutIntervalForRequest = self.timeoutInterval;
        return URLSession(configuration: configuration);
    }();
    

    private func request(path: String, method: RequestMethod = .get) throws -> URLRequest {
        let url = try self.url.append(path: path);
        var request = URLRequest(url: url);
        request.httpMethod = method.rawValue;
        return request;
    }
    
    
    func get<T:Decodable>(path: String, type: T.Type, completionHandler: @escaping (Result<T,Error>) -> Void) {
        do {
            let block: (Data?, URLResponse?, Error?) -> Void =  { data, response, error in
                do {
                    if let error = error {
                        throw error;
                    }
                    guard let response = response as? HTTPURLResponse else {
                        throw ServerError.httpResponse;
                    }
                    guard response.statusCode == 200 else {
                        throw response.HTTPError;
                    }
                    guard let data else {
                        throw ServerError.emptyResponse;
                    }
                    let decoder = JSONDecoder();
                    let result = try decoder.decode(type, from: data);
                    completionHandler( .success(result) );
                }
                catch {
                    completionHandler( .failure(error) );
                }
            }
            let request = try self.request(path: path);
            let task = self.session.dataTask(with: request, completionHandler: block);
            task.resume();
        }
        catch {
            completionHandler( .failure(error) );
        }
    }

}
