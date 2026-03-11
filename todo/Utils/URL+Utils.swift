//
//  NSURL+Utils.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;


enum URLError: Error {
    case url;
}


extension URL {
    
    func append(path: String) throws -> URL {
        guard let url = URL(string: path, relativeTo: self) else {
            throw URLError.url;
        }
        return url;
    }
    
}
