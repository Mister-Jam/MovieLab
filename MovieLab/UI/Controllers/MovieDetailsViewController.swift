//
//  MovieDetailsViewController.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var loadDetailsService: NetworkService?
    var movieID: Int
    var backdropImage: String
    var detailsViewModel: MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackgroundImage()
        loadRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetup()
        setupSubviews()
        scrollViewSetup()
    }
    
    init(id: Int, image: String) {
        self.movieID = id
        self.backdropImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadRequest() {
        loadDetailsService?.loadRequest(path: "\(Constants.URLPaths.details)\(movieID)", model: MovieDetailsModel.self, completion: handleUrlRequest)
        
    }
    
    private func loadBackgroundImage() {
        loadImage(path: backdropImage, imageView: summaryView.movieImage)
    }
    
    private func navigationBarSetup() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = Constants.Colors.background2
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.normalText
    }
    
    internal func handleUrlRequest(result: Result<MovieDetailsModel, Error>) {
        switch result {
        case .success(let data):
            detailsViewModel = MovieDetailsViewModel(dataSource: data)
            if let vm = detailsViewModel {
                self.configureViews(with: vm)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    private func loadImage(path: String, imageView: UIImageView) {
        let stringUrl = Constants.Images.baseUrl.rawValue+path
        if let url = URL(string: stringUrl) {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = Constants.Colors.background2
        scrollView.layoutIfNeeded()
        return scrollView
    }()
    
    private let detailsView: MovieDetailsView = {
        let detailsView = MovieDetailsView()
        return detailsView
    }()
    
    private let summaryView: MovieSummaryView = {
        let view = MovieSummaryView()
        return view
    }()
    
    private let companiesView: CompaniesCollectionView = {
        let actorsView = CompaniesCollectionView()
        return actorsView
    }()

    private func scrollViewSetup() {
        view.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        scrollView.contentSize = CGSize(width: view.width, height: view.height)
        scrollView.addMultipleSub(views: [summaryView, companiesView, detailsView])
    }
    
    func configureViews(with model: MovieDetailsViewModel) {
        let summaryData = SummaryViewModel(dataSource: model)
        summaryView.configureView(with: summaryData)
        companiesView.companiesData = model.companies
        companiesView.collectionView.reloadData()
        let item = DetailsViewModel(dataSource: model)
        detailsView.configureView(with: item)
    }

    func setupSubviews() {
        summaryView.frame = CGRect(x: 5, y: 5, width: view.width-10, height: view.height*0.65)
        companiesView.frame = CGRect(x: 0, y: summaryView.bottom+15, width: view.width, height: view.height/6)
        detailsView.frame = CGRect(x: 0, y: companiesView.bottom+10, width: view.width, height: view.height/2)
    }
}
