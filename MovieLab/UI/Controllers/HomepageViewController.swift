//
//  ViewController.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import UIKit

class HomepageViewController: UITableViewController {
    
    var tableModel = [MovieViewModel]()
    var loadMoviesService: NetworkService?
    let realm = RealmDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerTableViewCell(cell: HomepageTableViewCell.self)
        setupNavigationBar()
        loadFromCache()
        loadFromApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func loadFromCache () {
        let dataBase = realm.movieListObjects
        let item = dataBase.map { realm.convertCacheToViewModel(dataSource: $0) }
        tableModel = item
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = Constants.Colors.backgroundColor
        navigationController?.navigationBar.barTintColor = Constants.Colors.backgroundColor
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.titleText
        navigationController?.navigationBar.titleTextAttributes = Constants.normalText
    }

    
    internal func resultHandler(_ name: String, result: Result<MovieListModel, Error>) {
        switch result {
        case .success(let data):

            let item = MovieViewModel(name: name, data: data.results)
            realm.updateDatabase(dataSource: item)
            let index = tableModel.firstIndex { $0.categoryName == item.categoryName}
            if let itemIndex = index {
                tableModel[itemIndex] = item
            }
            self.tableView.reloadData()
        case .failure(let error):
            tableView.tableHeaderView = Constants.createTableHeader(text: error.localizedDescription)
            print(error)
        }
    }
    
    private func loadFromApi() {
        loadMoviesService?.loadRequest(path: Constants.URLPaths.nowPlaying,
                                       model: MovieListModel.self, completion: { [weak self] result in
                                        self?.resultHandler("Now Playing", result: result) })
        
        loadMoviesService?.loadRequest(path: Constants.URLPaths.popular,
                                       model: MovieListModel.self, completion: { [weak self] result in
                                        self?.resultHandler("Popular", result: result) })
        loadMoviesService?.loadRequest(path: Constants.URLPaths.rated,
                                       model: MovieListModel.self, completion: { [weak self] result in
                                        self?.resultHandler("Top Rated", result: result) })
        
        loadMoviesService?.loadRequest(path: Constants.URLPaths.upcoming,
                                       model: MovieListModel.self, completion: { [weak self] result in
                                        self?.resultHandler("Upcoming", result: result) })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(with: HomepageTableViewCell.self, indexPath: indexPath) as? HomepageTableViewCell {
            cell.delegate = self
            let item = tableModel[indexPath.row]
            cell.configureCell(with: item)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.height/2
    }
    
}

extension HomepageViewController: MovieDelegate {
    func movieTapped(title: String, movieId: Int, backdrop: String) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        let vc = MovieDetailsViewController(id: movieId, image: backdrop)
        vc.loadDetailsService = loadMoviesService
        vc.title = title
        show(vc, sender: self)
    }
}

