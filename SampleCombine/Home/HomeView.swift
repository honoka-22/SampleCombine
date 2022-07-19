//
//  HomeView.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/08.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ViewModel(apiService: APIService())
    
    var cardSpace: CGFloat = 64
    var hidenCardWidth: CGFloat = 20
    var cardLength: CGFloat
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    
    @State private var offset = CGFloat.zero
    @State private var stackWidth: CGFloat = CGFloat.zero
    
    init() {
        self.cardLength = screenWidth - (cardSpace * 2) - (hidenCardWidth * 2)
        
    }
    
    var body: some View {
        
        ScrollView(.horizontal) {
            
            HStack(spacing: cardSpace) {
                if viewModel.isLoading {
                    Text("読込中")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .offset(x: 0, y: -200)
                    
                } else {
                    ForEach(viewModel.movieInputs) { input in
                        MovieView(input: input)
                            .frame(maxWidth: cardLength, maxHeight: .infinity, alignment : .top)
                        
                    }
                }
            }.padding()
            
        }
        
        
        
        
    }
}

