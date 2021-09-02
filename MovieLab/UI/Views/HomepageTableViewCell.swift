//
//  HomepageTableViewCell.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import UIKit

protocol MovieDelegate: AnyObject {
    func movieTapped(title: String, movieId: Int, backdrop: String)
}

class HomepageTableViewCell: UITableViewCell {
    
    weak var delegate: MovieDelegate?
    var movieItems = [MovieListViewModel]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Colors.backgroundColor
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCollectionViewCell(cell: MovieListCollectionViewCell.self)
        return collectionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia-BoldItalic", size: 25)
        label.textColor = .white
        return label
    }()
    
    public func configureCell(with model: MovieViewModel) {
        titleLabel.text = model.categoryName
        movieItems = model.results.map { MovieListViewModel(dataSource: $0) }
    }
    
    private func setupCellSubviews() {
        let titleLabelHeight: CGFloat = contentView.height*0.15
        let collectionHeight: CGFloat = contentView.width - (titleLabelHeight+5)
        contentView.addMultipleSub(views: [titleLabel, collectionView])
        titleLabel.frame = CGRect(x: 20, y: 0, width: contentView.width*0.6, height: titleLabelHeight)
        collectionView.frame = CGRect(x: 0, y: titleLabel.bottom+5, width: contentView.width, height: collectionHeight)
    }
}

extension HomepageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.width*0.75, height: collectionView.height)
    }
}

extension HomepageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(with: MovieListCollectionViewCell.self, indexPath: indexPath) as? MovieListCollectionViewCell {
            let item = movieItems[indexPath.row]
            cell.configureCell(with: item)
        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = movieItems[indexPath.row]
        delegate?.movieTapped(title: item.movieTitle, movieId: item.id, backdrop: item.backdropPath)
    }
}
