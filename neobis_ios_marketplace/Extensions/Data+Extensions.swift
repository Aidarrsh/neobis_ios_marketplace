//
//  Data+Extensions.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 25/6/23.
//

import Foundation

extension Data {
    
    mutating public func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
