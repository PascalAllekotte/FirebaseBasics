//
//  ContentView.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 29.08.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            TabView{
                
                FirestoreView()
                    .tabItem {
                        
                        Image(systemName: "pencil.line")
                        Text("Hinzufügen")

                        
                    }
                    .foregroundStyle(.black)
                
                CollectionView(title: "ss")
                    .tabItem {
                        
                        Image(systemName: "list.number")
                            Text("Liste")
                            .foregroundStyle(.black)
                    }

                
                
                
            }
            .tint(.black)
            
            
            
            
        }
    }
}

#Preview {
    ContentView()
}
