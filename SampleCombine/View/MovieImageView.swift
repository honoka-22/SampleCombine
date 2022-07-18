//
//  MovieImageView.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/13.
//

import SwiftUI

struct MovieImageView: View {
    @ObservedObject var viewModel: ViewModel
    
    var cardSpace: CGFloat = 64
    var hidenCardWidth: CGFloat = 20
    var cardLength: CGFloat
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    var count: Int
    
    @State private var offset = CGFloat.zero
    @State private var stackWidth: CGFloat = CGFloat.zero
    
    init(viewModel: ViewModel) {
        self.cardLength = screenWidth - (cardSpace * 2) - (hidenCardWidth * 2)
        self.viewModel = viewModel
        self.count = viewModel.movieInputs.count / 2
    }
    
    var body: some View {
        
        HStack(spacing: cardSpace) {
            
            ForEach(viewModel.movieInputs) { input in
                MovieView(input: input)
                
            }
        }
        .offset(x: CGFloat(viewModel.movieInputs.count / 2) * (cardSpace + cardLength) + stackWidth + offset)
        
        
        .gesture(DragGesture()
                 // 変化した時に実行
            .onChanged { val in
                if stackWidth == 0 {
                    if val.translation.width > 0{
                        self.offset = val.translation.width
                    }
                } else if stackWidth == 4 * (cardLength + cardSpace) {
                    if val.translation.width < 0 {
                        self.offset = val.translation.width
                    }
                } else {
                    self.offset = val.translation.width
                }
            }
                 // 終わった時に実行
            .onEnded { val in
                self.offset = .zero
                if stackWidth == 0 {
                    if val.translation.width > 100{
                        stackWidth += cardLength + cardSpace
                    }
                } else if stackWidth == 4 * (cardLength + cardSpace) {
                    if val.translation.width < -100 {
                        stackWidth -= cardLength + cardSpace
                    }
                } else {
                    if val.translation.width > 100 {
                        stackWidth += cardLength + cardSpace
                    } else if val.translation.width < -100 {
                        stackWidth -= cardLength + cardSpace
                    }
                }
            }
        )
        
        
        //        .contentShape(Rectangle())
        
        
    }
}

//struct MovieImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieImageView()
//    }
//}
