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
    var firstName: String = ""
    var nickName: String = ""
    var email: String = ""
    var lastName: String = ""
    var birthday: String = ""
    var phoneNumber: String = ""
    var getUserProtocol: GetUserProtocol!
    
    init(getUserProtocol: GetUserProtocol!) {
        self.getUserProtocol = getUserProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            return
        }
        
        getUserProtocol.fetchUserData(accessToken: accessToken) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.parseUserData(userData)
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }

    func parseUserData(_ userData: [String: Any]) {
        if let firstName = userData["first_name"] as? String {
            self.firstName = firstName
            DispatchQueue.main.async {
                self.mainView.nameField.text = firstName
            }
        }
        
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
        
        if let lastName = userData["last_name"] as? String {
            self.lastName = lastName
            DispatchQueue.main.async {
                self.mainView.lastNameField.text = lastName
            }
        }
        
        if let birthday = userData["birthday"] as? String {
            self.birthday = birthday
            DispatchQueue.main.async {
                self.mainView.birthdayField.text = birthday
            }
        }
        
        if let phoneNumber = userData["phone_number"] as? String {
            self.phoneNumber = phoneNumber
            DispatchQueue.main.async {
                self.mainView.numberLabel.text = phoneNumber
                self.mainView.numberLabel.textColor = .black
                self.mainView.numberButton.setTitle("Сменить номер", for: .normal)
            }
        }
    }
    
    @objc func numberPressed() {
        guard let first_name = mainView.nameField.text else { return }
        guard let last_name = mainView.lastNameField.text else { return }
        guard let birthday = mainView.birthdayField.text else { return }
        guard let image = mainView.profilePic.image else { return }

        if let imageURL = saveImageLocally(image)?.absoluteString {
            print(imageURL)
            let vc = NumberViewController(numberProtocol: NumberViewModel(
                first_name: first_name,
                last_name: last_name,
                birthday: birthday,
                photo: imageURL
            ))
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func saveImageLocally(_ image: UIImage) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent("profile_image.jpg")
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            do {
                try imageData.write(to: fileURL)
                return fileURL
            } catch {
                print("Failed to save image locally:", error)
                return nil
            }
        }
        
        return nil
    }


    func imageToBase64URI(_ image: UIImage) -> String? {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            let base64String = imageData.base64EncodedString()
            let photoURI = "data:image/jpeg;base64," + base64String
            return photoURI
        }
        return nil
    }

    
//    func multipartFormDataBody(_ boundary: String, _ fromName: String, _ image: UIImage) -> Data {
//
//        let lineBreak = "\r\n"
//        var body = Data()
//
//        body.append("--\(boundary + lineBreak)")
//        body.append("Content-Disposition: form-data; name=\"formName\"\(lineBreak + lineBreak)")
//        body.append("\(fromName + lineBreak)")
//
//        if let uuid = UUID() .uuidString.components(separatedBy: "-").first {
//
//            body.append("--\(boundary + lineBreak)")
//            body.append("Content-Disposition: form-data; name=\"imageUploads\"; filename=\"\(uuid).jpg\"\(lineBreak)")
//            body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
//            body.append(image.jpegData(compressionQuality: 0.99)!)
//            body.append(lineBreak)
//        }
//
//        body.append("--\(boundary)--\(lineBreak)")
//
//        return body
//    }
//
//
//    @objc func numberPressed() {
//        guard let first_name = mainView.nameField.text else { return }
//        guard let last_name = mainView.lastNameField.text else { return }
//        guard let birthday = mainView.birthdayField.text else { return }
//        guard let image = mainView.profilePic.image else { return }
//
//        if let imageData = createMultipartFormData(withImage: image, forKey: "photo") {
//            let vc = NumberViewController(numberProtocol: NumberViewModel(
//                first_name: first_name,
//                last_name: last_name,
//                birthday: birthday,
//                photo: imageData
//            ))
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }


    
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
