//
//  Movie.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/19.
//

import Foundation

struct MovieJSON: Decodable {
    // タイトル(英語表記)
    var title: String
    // タイトル(日本語表記)
    var original_title: String
    // 画像
    var movie_banner: String
    // あらすじ(英語表記)
    var description: String
    // 監督
    var director: String
    // プロデューサー
    var producer: String
    // 上映年
    var release_date: String
    // 上映時間
    var running_time: String
}
