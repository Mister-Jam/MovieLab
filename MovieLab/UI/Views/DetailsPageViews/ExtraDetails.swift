//
//  ExtraDetails.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import UIKit

class MovieDetailsView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    private let releaseStatusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let revenueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    func configureView(with model: DetailsViewModel) {
        let releaseDate = Constants.formatText(firstText: "Release Date", secondText: "\n\(model.releaseDate)")
        let releaseStatus = Constants.formatText(firstText: "Release Status", secondText: "\n\(model.releaseStatus)")
        let runtime = Constants.formatText(firstText: "Runtime", secondText: "\n\(model.runtime)")
        let revenue = Constants.formatText(firstText: "Revenue", secondText: "\n$\(model.revenue)")
        
        releaseDateLabel.attributedText = releaseDate
        releaseStatusLabel.attributedText = releaseStatus
        runtimeLabel.attributedText = runtime
        revenueLabel.attributedText = revenue
        
    }
    private func setupSubviews() {
        
        addMultipleSub(views: [releaseStatusLabel, releaseDateLabel, runtimeLabel, revenueLabel])
        let labelWIdth: CGFloat = self.width * 0.7
        let labelHeight: CGFloat = self.height * 0.2
        releaseStatusLabel.frame = CGRect(x: 20, y: 0, width: labelWIdth, height: labelHeight)
        
        releaseDateLabel.frame = CGRect(x: 20, y: releaseStatusLabel.bottom, width: labelWIdth, height: labelHeight)
        
        runtimeLabel.frame = CGRect(x: 20, y: releaseDateLabel.bottom, width: labelWIdth, height: labelHeight)
        
        revenueLabel.frame = CGRect(x: 20, y: runtimeLabel.bottom, width: labelWIdth, height: labelHeight)
    }
    
}
