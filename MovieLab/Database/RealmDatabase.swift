//
//  RealmMethods.swift
//  MovieLab
//
//  Created by King Bileygr on 9/2/21.
//

import Foundation
import RealmSwift

class RealmDatabase {
    
    init() {
        self.fetchFromDatabase()
    }
    
    public var movieListObjects = [MovieList]()
    private let realm = try! Realm()
    
    public func convertCacheToViewModel(dataSource: MovieList) -> MovieViewModel {
        let name = dataSource.categoryName
        let results: [Results] = dataSource.results.map {
            let item = Results(id: $0.id, title: $0.title, backdropPath: $0.backdropPath)
            return item
        }

        return MovieViewModel(name: name, data: results)
    }
    
    private func createRealmObject(from viewModel: MovieViewModel)-> MovieList {
        let results: [MovieListItems] = viewModel.results.map {
            let data = MovieListItems()
            data.id = $0.id
            data.title = $0.title
            data.backdropPath = $0.backdropPath
            return data
        }
        let task = MovieList()
        task.categoryName = viewModel.categoryName
        task.id = viewModel.categoryName
        task.results.append(objectsIn: results)
        return task
    }
    
    private func fetchFromDatabase() {
        movieListObjects = realm.objects(MovieList.self).map { $0 }
    }
    
    public func updateDatabase(dataSource: MovieViewModel) {
     
        do {
                try realm.write {
                let newTask = createRealmObject(from: dataSource)
                    realm.add(newTask, update: .modified)
            }
        } catch {
            debugPrint(error)
        }
    }
}
