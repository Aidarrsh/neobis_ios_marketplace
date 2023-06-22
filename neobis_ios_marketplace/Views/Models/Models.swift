//
//  Models.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 20/6/23.
//

import Foundation

struct Login: Codable {
    let username: String
    let password: String
}

struct RegistrationModel: Codable {
    let username: String
    let email: String?
    let password: String
    let password_repeat: String
}
