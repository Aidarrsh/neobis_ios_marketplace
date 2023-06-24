//
//  NumberViewModel.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 23/6/23.
//

import Foundation
import UIKit
import Alamofire

protocol NumberProtocol {
    var isRegistered: Bool { get }
    var registerResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func fullRegister(phone_number: String)
}

class NumberViewModel: NumberProtocol {
    
    var isRegistered: Bool = false
    var registerResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    private let last_name: String
    private let birthday: String
    
    init(last_name: String, birthday: String) {
        self.apiService = APIService()
        self.last_name = last_name
        self.birthday = birthday
    }
    
    func fullRegister(phone_number: String) {
        var parameters: [String: Any] = ["last_name": last_name, "birthday": birthday, "phone_number": phone_number]
        
        guard let accessToken = AuthManager.shared.accessToken else {
            return
        }
        
//        print(accessToken)
            
        let endpoint = "account/full_register/"
        
        apiService.postWithBearerToken(endpoint: endpoint, parameters: parameters, bearerToken: accessToken) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isRegistered = true
                    self?.registerResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed register number: \(error.localizedDescription)"
                    print(errorMessage)
//                    print("Failed register number")
                    self?.isRegistered = false
                    self?.registerResult?(.failure(error))
                }
            }
        }
    }
}
