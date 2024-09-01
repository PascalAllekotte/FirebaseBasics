//
//  ScrollViewModifiers.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 31.08.24.
//

import SwiftUI

struct ScrollViewModifiers: View {
    // MARK: Variables -
    
    
    @StateObject private var viewModel = FirestoreViewModel()
    
    
    
    var body: some View {
        
        ScrollView(.horizontal){
            
            HStack{
                ForEach(viewModel.exampleModel){ example in
                    
                    VStack(alignment: .leading){
                        Text(example.title)
                            .font(.headline)
                        
                        Text(example.text)
                            .font(.subheadline)
                        
                    }
                    .padding()
                    .frame(width: 170, height: 170)
                    .background(.blue.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .containerRelativeFrame(.horizontal, count: 2, spacing: 10)
                    .scrollTransition {
                        content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.0)
                    }
                    
                }
            }
            
            .onAppear{
                viewModel.fetchCollection(collectionName: "Horror")
            }
            
        }
        .contentMargins(16, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.never)
        
        
    }
    
    
    
}

#Preview {
    ScrollViewModifiers()
}
