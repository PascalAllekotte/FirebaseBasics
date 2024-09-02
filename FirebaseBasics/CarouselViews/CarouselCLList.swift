//
//  CarouselCLList.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 02.09.24.
//

import SwiftUI

struct CarouselCLList: View {
    @StateObject private var viewModel = FirestoreViewModel()
    
    @State private var appear: [Bool]
    
    @Binding var title: String
    
    init(title: Binding<String>) {
        self._title = title
        _appear = State(initialValue: Array(repeating: false, count: 10))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.exampleModel.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 10) {
                                if let imageUrl = URL(string: viewModel.exampleModel[index].imageURL) {
                                    AsyncImage(
                                        url: imageUrl,
                                        content: { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        },
                                        placeholder: {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                    )
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(viewModel.exampleModel[index].title)
                                        .font(.headline)
                                    
                                    Text(viewModel.exampleModel[index].text)
                                        .font(.subheadline)
                                        .foregroundStyle(.black.opacity(0.7))
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .opacity(appear[index] ? 1 : 0)
                            .offset(x: appear[index] ? -10 : 500)
                            .onAppear {
                                startAnimationSequentially()
                            }
                            
                            Divider()
                        }
                        
                    }
                    .padding(.bottom, 100)

                }
            }
            .onAppear {
                viewModel.fetchCollection(collectionName: title)
            }
        }
        .onChange(of: title) { _, newValue in
            resetAppearAnimation()
            viewModel.fetchCollection(collectionName: newValue)
        }
    }
    
    private func resetAppearAnimation() {
        appear = Array(repeating: false, count: appear.count)
        startAnimationSequentially()
    }

    private func startAnimationSequentially() {
        for index in appear.indices {
            let delay = Double(index) * 0.5
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.easeOut(duration: 0.3)) { 
                    appear[index] = true
                }
            }
        }
    }
}

#Preview {
    CarouselCLList(title: .constant("Action"))
}

