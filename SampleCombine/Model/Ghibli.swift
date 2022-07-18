//
//  GhibliJSON.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/07.
//

import Foundation

struct Ghibli: Decodable {
    // 映画のID
    let id: String
    // 英語表記のタイトル
    let title: String
    // 画像URL
    let image: String
}

