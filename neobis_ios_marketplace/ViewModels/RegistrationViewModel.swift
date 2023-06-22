//
//  RegistrationViewModel.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 22/6/23.
//

import Foundation
import UIKit

protocol RegisterProtocol {
    var isRegistered: Bool { get }
    var registerResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func register(username: String, email: String?, password: String, password_repeat: String)
}

class RegisterViewModel: RegisterProtocol {
    
    var isRegistered: Bool = false
    var registerResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func register(username: String, email: String?, password: String, password_repeat: String) {
        let parameters: [String: Any] = ["username": username, "email": email!, "password": password, "password_repeat": password_repeat]
        
        apiService.post(endpoint: "account/register/", parameters: parameters) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isRegistered = true
                    self?.registerResult?(.success(data))
                case .failure(let error):
                    print("Failed register")
                    self?.isRegistered = false
                    self?.registerResult?(.failure(error))
                }
            }
        }
    }
}
