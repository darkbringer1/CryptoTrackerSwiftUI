//
//  Codable+Extensions.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            return try JSONSerialization.jsonObject(
                with: data,
                options: .fragmentsAllowed
            ) as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }
}
