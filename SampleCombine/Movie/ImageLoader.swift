//
//  ImageLoader.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/12.
//

//
//  ImageLoader.swift
//  GitHubAPIClient
//
//  Created by cmStudent on 2022/07/12.
//

import Foundation
import UIKit

// URLから画像に変換する
class ImageLoader: ObservableObject {
    var image: UIImage
    private let catJsonConverter = JSONConverter(urlString: "https://aws.random.cat/meow")
    
    init(image: String) {
        self.image = UIImage(named: image)!
    }
    
    getImage() {
        
    }

    /// 猫の画像を取得する
    func getCatImage() {
        isProgress = true
        // クロージャー呼び出し
        catJsonConverter.resume { data, response, error in
            // dataがあるかどうか?あれば使う。
            guard let data = data else { return }
            // エラーハンドリング
            do {
                // 受け取ったJSONデータをパースして格納
                let cat = try JSONDecoder().decode(Cat.self, from: data)
                
                guard let url = URL(string: cat.file) else { return }
                
                guard let data = try? Data(contentsOf: url) else { return }
                
                self.image = UIImage(data: data)!
                
                DispatchQueue.main.async {
                    self.isProgress = false
                }
                
            } catch let error {
                print(error)
                self.isProgress = false
            }
            
            
        }
        
        
    }
    
    
}
