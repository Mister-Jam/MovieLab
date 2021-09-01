//
//  ProductionCompanyCollectionView.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import UIKit

class CompaniesCollectionView: UIView {
    
    var companiesData = [Companies]()
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.text = "Production Companies"
        label.font = UIFont(name: "Georgia-BoldItalic", size: 20)
        return label
    }()
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerCollectionViewCell(cell: ActorsCollectionViewCell.self)
        return collectionView
    }()
    
    private func setupSubviews() {
        self.addMultipleSub(views: [titleLabel, collectionView])
        
        titleLabel.frame = CGRect(x: 25, y: 10, width: self.width*0.7, height: self.height/6)
        collectionView.frame = CGRect(x: 10, y: titleLabel.bottom+15, width: self.width - 10, height: self.height - ((self.height/6) + 30))
    }
}

extension CompaniesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        companiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(with: ActorsCollectionViewCell.self, indexPath: indexPath) as? ActorsCollectionViewCell {
            let item = companiesData[indexPath.row]
            cell.configureCell(with: item)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension CompaniesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.width/6, height: collectionView.height)
    }
}
