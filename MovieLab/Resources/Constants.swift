//
//  Constants.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import UIKit


struct Constants {
    static let titleText    = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              .font: UIFont.systemFont(ofSize: 30, weight: .bold)]
    static let normalText   = [NSAttributedString.Key.foregroundColor: UIColor.white,
                               .font: UIFont.systemFont(ofSize: 18, weight: .bold)]
    
    enum Colors {
        static let backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.1764705882, blue: 0.3058823529, alpha: 1)
        static let background2 = UIColor(red: 167/255, green: 37/255, blue: 78/255, alpha: 1)
        static let goldColor = UIColor(red: 255/255, green: 223/255, blue: 0/255, alpha: 1)
    }
    
    enum URLPaths {
        static let nowPlaying = "/3/movie/now_playing"
        static let popular = "/3/movie/popular"
        static let rated = "/3/movie/top_rated"
        static let upcoming = "/3/movie/upcoming"
        static let details = "/3/movie/"
    }
    
    enum Images: String {
        case baseUrl = "https://image.tmdb.org/t/p/original"
    }
    
    static func formatText(firstText: String, secondText: String?) -> NSMutableAttributedString {
        
        let firstTextAttributes: [NSAttributedString.Key : NSObject]    = [.font : UIFont.systemFont(ofSize: 20, weight: .bold), .foregroundColor : UIColor.white]
        let secondTextAttributes: [NSAttributedString.Key : NSObject]   = [.font : UIFont.systemFont(ofSize: 16), .foregroundColor : Colors.goldColor]
        let attributedText      = NSMutableAttributedString(string: firstText, attributes: firstTextAttributes)
        if let secondText       = secondText {
            attributedText.append(NSAttributedString(string: secondText, attributes: secondTextAttributes))
        }
        let paragraphStyle       = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let length = attributedText.string.count
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: _NSRange(location: 0, length: length))
        return attributedText
    }
    
    static func createTableHeader(text: String) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        header.backgroundColor = .clear
        let NotificationLabel = UILabel()
        NotificationLabel.frame = CGRect(x: 0, y: 0, width: header.width*0.8, height: header.height*0.8)
        NotificationLabel.center = header.center
        NotificationLabel.textColor = .white
        NotificationLabel.layer.masksToBounds = true
        NotificationLabel.backgroundColor = .clear
        NotificationLabel.text = text
        NotificationLabel.textAlignment = .center
        NotificationLabel.numberOfLines = 0
        header.addSubview(NotificationLabel)
        return header
    }
    
    static func setGradientBackground(view: UIView, frame: CGRect) {
        let colorTop =  UIColor.clear.cgColor
        let colorMid = UIColor.clear.cgColor
        let colorBottom = UIColor(red: 0/255, green: 0/255, blue: 63/255, alpha: 0.5).cgColor
        let fourthColor = UIColor.clear.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMid, colorBottom, fourthColor]
        gradientLayer.locations = [0.25, 0.5, 0.75, 1.0]
        gradientLayer.frame = frame
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}
