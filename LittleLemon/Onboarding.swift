//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Josiah Agosto on 4/24/23.
//

import SwiftUI

var onboardingFirstName =  "onboardingFirstName"
var onboardingLastName =  "onboardingLastName"
var onboardingEmail =  "onboardingEmail"
var appStateIsLoggedIn = false

struct Onboarding: View {
    // MARK: - References / Properties
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                NavigationLink(value: "") {
                    Button("Register") {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: onboardingFirstName)
                            UserDefaults.standard.set(lastName, forKey: onboardingLastName)
                            UserDefaults.standard.set(email, forKey: onboardingEmail)
                            UserDefaults.standard.set(true, forKey: "appStateIsLoggedIn")
                            isLoggedIn = true
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear {
                appStateIsLoggedIn = UserDefaults.standard.bool(forKey: "appStateIsLoggedIn")
                isLoggedIn = appStateIsLoggedIn
            }
        }
    }
    
}
