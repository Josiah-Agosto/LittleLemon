//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Josiah Agosto on 4/24/23.
//

import SwiftUI

struct UserProfile: View {
    // MARK: - References / Properties
    @Environment(\.presentationMode) private var presentation
    @State private var firstName: String? = ""
    @State private var lastName: String? = ""
    @State private var email: String? = ""
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text("\(firstName ?? "")")
            Text("\(lastName ?? "")")
            Text("\(email ?? "")")
            Button("Logout") {
                presentation.wrappedValue.dismiss()
                UserDefaults.standard.set(false, forKey: "")
            }
            Spacer()
        }
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: "onboardingFirstName")
            lastName = UserDefaults.standard.string(forKey: "onboardingLastName")
            email = UserDefaults.standard.string(forKey: "onboardingEmail")
        }
    }
    
}
