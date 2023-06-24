//
//  FinishRegViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 19/6/23.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class FinishRegViewController: UIViewController {
    
    let mainView = FinishRegView()
    var nickName: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let finishButton = UIBarButtonItem(image: UIImage(named: "finish")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(finishPressed))
        self.navigationItem.rightBarButtonItem = finishButton
        
        mainView.setPicButton.addTarget(self, action: #selector(setPic), for: .touchUpInside)
        mainView.numberButton.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
        
        setupView()
        getUserData()
    }
    
    func getUserData() {
        guard let accessToken = AuthManager.shared.accessToken else {
            // Access token not available
            return
        }
        
//        print(accessToken)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request("http://16.16.200.195/api/v1/account/profile/", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
//                print(value)
                if let userData = value as? [String: Any] {
                    // Parse and use the user data
                    self.parseUserData(userData)
                }
            case .failure(let error):
                // Handle error
                print("Failed to fetch user data:", error)
            }
        }
    }


    func parseUserData(_ userData: [String: Any]) {
        if let username = userData["username"] as? String {
            self.nickName = username
            DispatchQueue.main.async {
                self.mainView.nickNameField.text = username
            }
        }
        
        if let email = userData["email"] as? String {
            self.email = email
            DispatchQueue.main.async {
                self.mainView.emailField.text = email
            }
        }
    }
    
    @objc func numberPressed() {
        guard let last_name = mainView.lastNameField.text else { return }
        guard let birthday = mainView.birthdayField.text else { return }
        guard let image = mainView.profilePic.image else { return }
        
        let imageData = image.jpegData(compressionQuality: 0.8) // Adjust the compression quality as needed

        let base64Image = imageData?.base64EncodedString() ?? ""

        let vc = NumberViewController(numberProtocol: NumberViewModel(last_name: last_name, birthday: birthday))

        
        navigationController?.pushViewController(vc, animated: true)
    }

    
    @objc func setPic() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func finishPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

extension FinishRegViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            mainView.profilePic.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
