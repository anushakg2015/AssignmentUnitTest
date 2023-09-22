//
//  Tokenmodel.swift
//  LoginUnitTest
//
//  Created by Anusha Kg on 22/09/23.
//

import SwiftUI
import Alamofire

struct TokenResponse: Decodable {
    let token: String?
    let expiresOn: String?

}


