//
//  ContentView.swift
//  LoginUnitTest
//
//  Created by Anusha Kg on 22/09/23.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var username = ""
    @State var password = ""
    @State var isPasswordHidden = true
    @State var isUserLoggedIn = false
    
    @ObservedObject var viewModel = TokenViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundimage")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(1.0)
                
                VStack {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.system(size: 40, design: .rounded))
                        .offset(y: -220)
                    
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .offset(y: -180)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                        .offset(y: -180)
                    
                    HStack {
                        if isPasswordHidden {
                            SecureField("Password", text: $password)
                                .accentColor(.white)
                        } else {
                            TextField("Password", text: $password)
                                .accentColor(.white)
                        }
                        
                        Button(action: {
                            isPasswordHidden.toggle()
                        }) {
                            Image(systemName: isPasswordHidden ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .offset(y: -140)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                        .offset(y: -140)
                    
                    Button(action: {
                        viewModel.fetchToken(username: username, password: password)
                    }) {
                        Text("Login")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.white.opacity(0.5))
                            )
                            .foregroundColor(.red)
                    }
                    .offset(y: -100)
                    
                    Button(action: {
                        // Handle Forgot Password action
                    }) {
                        Text("Forgot Password?")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .offset(y: -70)
                    
                    if let error = viewModel.loginError {
                        Text(error)
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    NavigationLink(destination: WelcomeView(), isActive: $isUserLoggedIn) {
                        EmptyView()
                    }
                }
                .frame(width: 350)
            }
            .onReceive(viewModel.$isLoggedIn) { loggedIn in
                // When isLoggedIn changes to true, set isUserLoggedIn to true for navigation
                isUserLoggedIn = loggedIn
            }
        }
    }
}

