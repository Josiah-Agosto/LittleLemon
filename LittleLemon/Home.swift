//
//  Home.swift
//  LittleLemon
//
//  Created by Josiah Agosto on 4/24/23.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}
