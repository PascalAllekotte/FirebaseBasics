//
//  LowerCarouselView.swift
//  FirebaseBasics
//
//  Created by Pascal Allekotte on 01.09.24.
//

import SwiftUI

struct LowerCarouselView: View {
    // MARK: Variables -
    @State private var pickerType: FilmPicker = .normal
    @State private var activeID: Int?
    
    
    var body: some View {
        VStack{
            Picker("", selection: $pickerType) {
                ForEach(FilmPicker.allCases, id:  \.rawValue) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Spacer(minLength: 0)
            
            GeometryReader{
                let size = $0.size
                let padding = (size.width - 70) / 2
                
                
                ScrollView(.horizontal){
                    HStack(spacing: 35){
                        ForEach(1...6, id: \.self) { index in
                            Image("pic \(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                                .visualEffect { view, proxy in
                                    view
                                        .offset(y: offset(proxy))
                                        .offset(y: scale(proxy) * -15 )
                                }
                                .scrollTransition(.interactive, axis: .horizontal){ view, phase in
                                    view
                                      //  .offset(y: phase.isIdentity && activeID == index ? 15 : 0 )
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
                            .fill(.white.shadow(.drop(color: .red.opacity(0.5), radius: 8)))
                            .frame(width: 85, height: 85)
                            .offset(y: -34)
                        Circle()
                            .fill(.white.shadow(.drop(color: .blue.opacity(0.8), radius: 5)))
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
        .ignoresSafeArea(.container, edges: .bottom)
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
    LowerCarouselView()
}

enum FilmPicker: String, CaseIterable {
    
    case scaled = "Scaled"
    case normal = "Normal"
    
    
}

