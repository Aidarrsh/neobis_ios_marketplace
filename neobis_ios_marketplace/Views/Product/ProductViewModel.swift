//
//  ProductViewModel.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 5/7/23.
//

import Foundation
import Alamofire

protocol GetProductProtocol {
    func fetchProductData(completion: @escaping (Result<[[String: Any]], Error>) -> Void)
}

class GetProductViewModel: GetProductProtocol {
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    func fetchProductData(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else {
            let error = NSError(domain: "AuthorizationError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access token is missing"])
            completion(.failure(error))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        apiService.fetchProductData(headers: headers) { result in
            switch result {
            case .success(let dataArray):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dataArray, options: .prettyPrinted)
                    let jsonString = String(data: jsonData, encoding: .utf8)
//                    print(jsonString ?? "")
                    completion(.success(dataArray))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
