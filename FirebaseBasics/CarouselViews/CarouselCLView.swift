//
//  LowerCarouselView.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 01.09.24.
//

import SwiftUI

struct CarouselCLView: View {
    // MARK: Variables -
    @State private var activeID: Int?
    @State private var selectedTitle: String = "Action"

    
    // MARK: VIEW -
    var body: some View {
        VStack {
            
            CarouselCLList(title: $selectedTitle)
                .padding(.top, 20)
                
            ZStack {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.white, .clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    ))
                    .frame(height: 30)
            }
            .padding(.top, -30)

            Spacer(minLength: 9)

            GeometryReader { geo in
                let size = geo.size
                let padding = (size.width - 70) / 2

                ScrollView(.horizontal) {
                    HStack(spacing: 35) {
                        ForEach(1...6, id: \.self) { index in
                            VStack {
                                Image("pic \(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())

                                Text(genreForIndex(index))
                                    .bold()
                                    .foregroundStyle(.black)
                                    .padding(.top, 5)
                            }
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                            .visualEffect { view, proxy in
                                view
                                    .offset(y: offset(proxy))
                            }
                         
                        }
                    }
                    .frame(height: size.height)
                    .offset(y: -19)
                    .scrollTargetLayout()
                }
                .background {
                    Circle()
                        .fill(Color.white.shadow(.drop(color: .black.opacity(0.5), radius: 8)))
                        .frame(width: 85, height: 85)
                        .offset(y: -35.5)
                }
                .safeAreaPadding(.horizontal, padding)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $activeID)
                .frame(height: size.height)
                .onChange(of: activeID) { _, newValue in
                    selectedTitle = genreForIndex(newValue ?? 1)
                }
            }
            .frame(height: 200)
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

    // MARK: Functions -
    private func genreForIndex(_ index: Int) -> String {
        switch index {
        case 1: return "Action"
        case 2: return "Horror"
        case 3: return "Komödie"
        case 4: return "Thriller"
        case 5: return "Sei-Fi"
        case 6: return "Fantasy"
        default: return "Unbekannt"
        }
    }

    func offset(_ proxy: GeometryProxy) -> CGFloat {
        let progress = progress(proxy)
        return progress < 0 ? progress * -30 : progress * 30
    }

    func progress(_ proxy: GeometryProxy) -> CGFloat {
        let viewWidth = proxy.size.width
        let minX = (proxy.bounds(of: .scrollView)?.minX ?? 0)
        return minX / viewWidth
    }
}

#Preview {
    CarouselCLView()
}
