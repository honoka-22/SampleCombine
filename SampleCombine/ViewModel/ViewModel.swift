//
//  ViewModel.swift
//  SampleCombine
//
//  Created by cmStudent on 2022/07/07.
//

import Foundation
import Combine
import UIKit

class ViewModel: ObservableObject {
    @Published var isLoading = false
    
    @Published private(set) var movieInputs: [MovieView.Input] = []
    var image: UIImage? = nil
    
    private let apiService: APIServiceType
    private let onCommitSubject = PassthroughSubject<String, Never>()
    private let responseSubjeczt = PassthroughSubject<MovieRequest, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
        bind()
        load(id: "")
    }
    
    func bind() {
        onCommitSubject
            .flatMap {id in
                self.apiService.request(with: MovieRequest(id: id))
                    .catch { error -> Empty<[Ghibli], Never> in
                        self.errorSubject.send(error)
                        return Empty()
                    }
            }
            
        // Subscriver
            .sink { movies in
                // CardViewで使える形にしたい
                self.movieInputs = self.convertInput(movies: movies)
                // 仮定
                self.isLoading = false
            }
            .store(in: &cancellable)
        
        onCommitSubject
            .map { _ in true }
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellable)
        // TODO:
        errorSubject
            .sink { _ in
                
            }
            .store(in: &cancellable)
        
    }
    
    private func convertInput(movies: [Ghibli]) -> [MovieView.Input] {
        var inputs: [MovieView.Input] = []
        for movie in movies {
            guard let url = URL(string: movie.image) else {
                print("画像URLが正しくありません")
                continue
            }
            
            // インターネットから画像データを取得する
            let data = try? Data(contentsOf: url)
            // データを画像化
            let image = UIImage(data: data ?? Data()) ?? UIImage()
            
            inputs.append(MovieView.Input(id: movie.id, image: image, title: movie.title))
        }
        return inputs
    }
    
    func load(id: String) {
        onCommitSubject.send(id)
    }
    
    
}
