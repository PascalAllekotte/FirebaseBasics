//
//  FirestoreView.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 29.08.24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct FirestoreView: View {
    // MARK: Variables -
    
    @State private var newCollection = ""
    @State private var documentName = ""
    @State private var title = ""
    @State private var text = ""
    @State private var image = ""


    
/*
    @State private var newCollection = ExampleModel(
        id: UUID().uuidString,
        collection: "",
        documentName: "",
        detail: ""
        
    )
*/
    
    @StateObject var viewModel = FirestoreViewModel()
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Collection")
                    .font(.subheadline)
                    .padding(.horizontal, 6)
                    .fontWeight(.bold)
                Spacer()
            }
            TextField("Collection", text: $newCollection)
                .padding()
                .background(.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
                .padding(.horizontal)
            HStack{
                Text("Filmtitel")
                    .font(.subheadline)
                    .padding(.horizontal, 6)
                
                    .fontWeight(.bold)
                Spacer()
            }
            TextField("Dokumentname", text: $title)
                .padding()
                .background(.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            HStack{
                Text("Inhalt")
                    .font(.subheadline)
                    .padding(.horizontal, 6)
                    .fontWeight(.bold)
                Spacer()
            }
   
            
            
            TextField("Text", text: $text)
                .padding()
                .background(.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            Spacer()
            HStack{
                
                
                
                Spacer()
            
                Button("Hinzufügen"){
                    if newCollection.isEmpty {
                        print("Collection ist leer")
                    } else {
                        let newExample = ExampleModel(imageURL: image, title: title, text: text)
                        viewModel.addCollection(newCollection: newCollection, documentName: title, example: newExample)
                        
                    }
                }
                .padding()
                .background(.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                
            }
            
            .padding()
            
        }
        .background(.blue.opacity(0.2))
        
        
    }
}

#Preview {
    FirestoreView()
}
