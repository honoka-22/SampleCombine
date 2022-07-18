//
//  CardView.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/08.
//

import SwiftUI

struct CardView: View {
    struct Input: Identifiable {
        let id: UUID = UUID()
        let title: String
        let image: UIImage
    }
    let input: Input
    
    var body: some View {
        VStack {
            Image(uiImage: input.image)
            Text(input.title)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(input: CardView.Input(
            title: "タイトル",
            // FIXME: 修正
            image: UIImage(named: "hedgehog")!
        ))
    }
}
