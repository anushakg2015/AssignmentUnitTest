//
//  TokenViewModel.swift
//  LoginUnitTest
//
//  Created by Anusha Kg on 22/09/23.
//

import Foundation
import Alamofire

class TokenViewModel: ObservableObject {
    @Published var loginError: String?
    @Published var tokenData: TokenResponse?
    @Published var isLoggedIn: Bool = false
    
    
    func fetchToken(username: String, password: String) {
        let credentials = "\(username):\(password)"
        if let credentialsData = credentials.data(using: .utf8)?.base64EncodedString() {
            let headers: HTTPHeaders = [
                "X-Nspire-AppToken": "f07740dc-1252-48f3-9165-c5263bbf373c",
                "Authorization": "Basic \(credentialsData)"
            ]
            
            AF.request("https://identity-stage.spireon.com/identity/token", method: .get, headers: headers).responseDecodable(of: TokenResponse.self) { response in
                switch response.result {
                case .success(let tokenResponse):
                    if let token = tokenResponse.token, let expiresOn = tokenResponse.expiresOn {
                        let tokenData = TokenResponse(token: token, expiresOn: expiresOn)
                        self.tokenData = tokenData
                        self.isLoggedIn = true
                        self.loginError = nil // Clear any previous login errors
                    } else {
                        self.loginError = "Token or expiresOn is missing in the response."
                    }
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        self.loginError = "HTTP Status Code: \(statusCode)"
                    } else {
                        self.loginError = "Error: \(error)"
                    }
                }
            }
        }
    }
}
