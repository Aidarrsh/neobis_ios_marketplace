//
//  AddProductViewModel.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 29/6/23.
//

import Foundation

protocol AddProductViewModelProtocol: AnyObject {
    var isAdded: Bool { get }
    var addResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func addProduct(images: [Data], title: String, price: String, shortDescription: String?, fullDescription: String?)
}

class AddProductViewModel: AddProductViewModelProtocol {
    
    var isAdded: Bool = false
    var addResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func addProduct(images: [Data], title: String, price: String, shortDescription: String?, fullDescription: String?) {
        let endpoint = "product/"
        
        let parameters: [String: Any] = [
            "images": images,
            "title": title,
            "price": price,
            "short_description": shortDescription ?? "",
            "full_description": fullDescription ?? ""
        ]
        
        apiService.postWithBearerToken(endpoint: endpoint, parameters: parameters, bearerToken: AuthManager.shared.accessToken ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isAdded = true
                    self?.addResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed to add product: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isAdded = false
                    self?.addResult?(.failure(error))
                }
            }
        }
    }
}
