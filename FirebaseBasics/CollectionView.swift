//
//  CollectionView.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 31.08.24.
//

import SwiftUI

struct CollectionView: View {
    @StateObject private var viewModel = FirestoreViewModel()
    
    
    
    var body: some View {
        NavigationStack{
            
            VStack{
                ScrollView{
                    
                    VStack(alignment: .leading){
                        
                        ForEach(viewModel.exampleModel){ example in
                            HStack(alignment: .top, spacing: 10){
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(Color.random)
                                
                                VStack(alignment: .leading){
                                    Text(example.title)
                                        .font(.headline)
                                    
                                    Text(example.text)
                                        .font(.subheadline)
                                        .foregroundStyle(.black.opacity(0.7))
                                }
                                
                            }
                            

                            Divider()

                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    
                    .onAppear{
                        viewModel.fetchCollection(collectionName: "Horror")
                    }
                }
                
            }.padding()
            .background(.blue.opacity(0.2))

        }

        
    }
}

extension Color {
    static var random: Color {
        let colors: [Color] = [.red, .blue, .green, .brown, .cyan, .orange]
        return colors.randomElement() ?? .black
    }
}

#Preview {
    CollectionView()
}
