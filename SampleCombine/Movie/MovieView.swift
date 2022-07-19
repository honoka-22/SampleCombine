//
//  MovieView.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/14.
//

import SwiftUI

struct MovieView: View {
    struct Input: Identifiable {
        let id: String
        /// ポスターの画像
        let image: UIImage
        /// タイトル
        let title: String
        
    }

    let input: Input
    
    var cardSpace: CGFloat = 64
    var hidenCardWidth: CGFloat = 20
    var cardLength: CGFloat
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    init(input: Input) {
        self.cardLength = screenWidth - (cardSpace * 2) - (hidenCardWidth * 2)
        self.input = input
    }
    

    
    var body: some View {
        VStack {
            Image(uiImage: input.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: cardLength)
            
            Text(input.title)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                
                
        }
        
    }
}


