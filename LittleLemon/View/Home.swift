//
//  Home.swift
//  LittleLemon
//
//  Created by Josiah Agosto on 4/24/23.
//

import SwiftUI

struct Home: View {
    // MARK: - References / Properties
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
