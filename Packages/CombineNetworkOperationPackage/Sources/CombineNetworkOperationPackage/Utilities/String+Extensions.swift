//
//  String+Extensions.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation

extension String {
    
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkRequestError.missingURL }
        return url
    }
}
