//
//  Menu.swift
//  LittleLemon
//
//  Created by Josiah Agosto on 4/24/23.
//

import SwiftUI
import CoreData

struct Menu: View {
    // MARK: - References / Properties
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]) var menuItems: FetchedResults<Dish>
    @State private var searchText: String = ""
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            menuItems.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "title CONTAINS[cd] %@", newValue)
        }
    }
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("This is a short description of this boring app.")
            TextField("Search menu", text: query)
            List {
                ForEach(menuItems, id: \.title) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.title ?? "")")
                            Text("\(item.itemDescription ?? "")")
                            Text("\(item.price ?? "")")
                        }
                        AsyncImage(url: URL(string: item.image ?? "")!) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    
    private func getMenuData() {
        PersistenceController.shared.clear()
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let urlRequest = URLRequest(url: URL(string: url)!)
        let dataTask =  URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            if let error = error {
                print("An error occurred fetching data from server. \(error.localizedDescription)")
            } else {
                if response.statusCode == 200 {
                    guard let data = data else {
                        print("An error occurred fetching data from server.")
                        return
                    }
                    do {
                        let menuList = try JSONDecoder().decode(MenuList.self, from: data)
                        Dish.createDishesFrom(menuItems: menuList.menu, viewContext)
                    } catch let error {
                        print("An error occurred fetching data from server. \(error.localizedDescription)")
                    }
                } else {
                    print("An error occurred fetching data from server. \(response.statusCode)")
                }
            }
        }
        dataTask.resume()
    }
    
}
