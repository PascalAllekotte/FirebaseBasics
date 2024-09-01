//
//  LowerCarouselView.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 01.09.24.
//

import SwiftUI

struct CarouselCLView: View {
    // MARK: Variables -
    @State private var pickerType: FilmPicker = .normal
    @State private var activeID: Int?
    

    var body: some View {
        VStack{
            
            
            
            ZStack {
                
                Spacer()
                Color.gray.opacity(0.6)
                    .frame(width: .infinity, height: 600)

                    .clipShape(RoundedRectangle(cornerRadius: 12))

                        }
            .frame(width: .infinity, height: 600)

            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 12))

            .offset(CGSize(width: 0.0, height: 25.0))

        
            
            Spacer(minLength: 9)
            
            GeometryReader{
                let size = $0.size
                let padding = (size.width - 70) / 2
                
                ScrollView(.horizontal){
                    HStack(spacing: 35){
                        ForEach(1...6, id: \.self) { index in
                            VStack{
                                Image("pic \(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                                
                                // Setze den Text basierend auf dem Index
                                Text(genreForIndex(index))
                                    .bold()
                                    .foregroundStyle(.white.opacity(0.7))
                                    .padding(.top, 5)
                            }
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                            .visualEffect { view, proxy in
                                view
                                    .offset(y: offset(proxy))
                                    .offset(y: scale(proxy) * 1 )
                            }
                            .scrollTransition(.interactive, axis: .horizontal){ view, phase in
                                view
                                    .scaleEffect(phase.isIdentity && activeID == index && pickerType == .scaled ? 1.5 : 1.0, anchor: .bottom)
                            }
                        }
                    }
                    .frame(height: size.height)
                    .offset(y: -19)
                    .scrollTargetLayout()
                }
                .background(content: {
                    if pickerType == .normal {
                        Circle()
                            .fill(Color.gray.opacity(0.6).shadow(.drop(color: .blue.opacity(0.5), radius: 8)))
                            .frame(width: 85, height: 85)
                            .offset(y: -34)
                        
                    }
                })
                .safeAreaPadding(.horizontal, padding)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $activeID)
                .frame(height: size.height)
            }
            .frame(height: 200)
        }
        .background(.black.opacity(0.3))
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    // MARK: Functions -
    private func genreForIndex(_ index: Int) -> String {
        switch index {
        case 1: return "Action"
        case 2: return "Horror"
        case 3: return "Komödie"
        case 4: return "Thriller"
        case 5: return "Sci-Fi"
        case 6: return "Fantasy"
        default: return "Unbekannt"
        }
    }

    func offset(_ proxy: GeometryProxy) -> CGFloat {
        let progress = progress(proxy)
        return progress < 0 ? progress * -30 : progress * 30
    }
    
    func scale(_ proxy: GeometryProxy) -> CGFloat {
        let progress = min(max(progress(proxy), -1), 1)
        return progress < 0 ? 1 + progress : 1 - progress
    }
    
    func progress(_ proxy: GeometryProxy) -> CGFloat {
        let viewWidth = proxy.size.width
        let minX = (proxy.bounds(of: .scrollView)?.minX ?? 0 )
        return minX / viewWidth
    }
}

#Preview {
    CarouselCLView()
}

