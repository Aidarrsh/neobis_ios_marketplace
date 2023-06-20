//
//  LoginViewModel.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 20/6/23.
//

import Foundation

protocol LoginProtocol {
    var isLoggedIn: Bool { get }
    var loginResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func login(username: String, password: String)
}

class LoginViewModel: LoginProtocol {
    
    var isLoggedIn: Bool = false
    var loginResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func login(username: String, password: String) {
        let parameters: [String: Any] = ["username": username, "password": password]
        
        apiService.post(endpoint: "login/", parameters: parameters) { [weak self] (result) in
            DispatchQueue.main.async {
                print(result)
                switch result {
                case .success(let data):
//                    let dataString = String(data: data, encoding: .utf8)
//                    print("Data received: \(dataString ?? "nil")")
                    self?.isLoggedIn = true
                    self?.loginResult?(.success(data))
                case .failure(let error):
                    // Handle login failure
                    print("fail")
                    self?.isLoggedIn = false
                    self?.loginResult?(.failure(error))
                }
            }
        }
    }
}

    
//    func login(username: String, password: String) {
//        let loginData = Login(username: username, password: password)
//        let parameters = loginData.toParameters()
//
//        // Convert the login data to parameters if needed
//
//        let endpoint = "login" // Replace with the appropriate API endpoint
//
//        apiService.post(endpoint: endpoint, parameters: parameters) { [weak self] result in
//            switch result {
//            case .success(let data):
//                let dataString = String(data: data, encoding: .utf8)
////                print("Data received: \(dataString ?? "nil")")
//                print(username + password)
//                self?.isLoggedIn = true
//            case .failure:
//                self?.isLoggedIn = false
//            }
//
//            self?.loginResult?(result)
//        }
//    }
    
//    func login(username: String, password: String) {
//        let parameters: [String: Any] = ["username": username, "password": password]
//        
//        apiService.post(endpoint: "login/", parameters: parameters) { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                let dataString = String(data: data, encoding: .utf8)
//                print("Data received: \(dataString ?? "nil")")
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(Login.self, from: data)
//                    DispatchQueue.main.async {
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                }
//            }
//        }
//    }
