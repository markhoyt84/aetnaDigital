//
//  FlickrImageTableViewCell.swift
//  AetnaDigital
//
//  Created by Mark Hoyt on 3/29/17.
//  Copyright © 2017 Mark Hoyt. All rights reserved.
//

import UIKit
import Nuke

class FlickrImageTableViewCell: UITableViewCell {
    
    fileprivate let LABEL_MARGINS_X: CGFloat = 16.0
    
    fileprivate let TITLE_LABEL_HEIGHT: CGFloat = 25.0
    fileprivate let TITLE_LABEL_FONT_SIZE: CGFloat = 20.0
    
    fileprivate let OTHER_LABEL_HEIGHT: CGFloat = 20.0
    fileprivate let OTHER_LABEL_FONT_SIZE: CGFloat = 16.0
    
    let transparentColor = UIColor.black.withAlphaComponent(0.1).cgColor
    let opaqueColor = UIColor.black.withAlphaComponent(1.0).cgColor
    
    fileprivate var backgroundImageView: UIImageView!
    fileprivate var backgroundGradient: CAGradientLayer!
    fileprivate var titleLabel: UILabel!
    fileprivate var publishedDateLabel: UILabel!
    fileprivate var imageDimensionsLabel: UILabel!
    fileprivate var tagsLabel: UILabel!
    
    
    var currentImage: FlickrImage? {
        didSet {
            if let _currentImage = currentImage {
                if let _imageURLString = _currentImage.imageURL, let _imageURL = URL(string: _imageURLString)  {
                    Nuke.loadImage(with: _imageURL, into: self.backgroundImageView)
                }
                
                if let _title = _currentImage.title {
                    self.titleLabel.text = _title
                }
                
                if let _publishedDate = _currentImage.publishedDate {
                    self.publishedDateLabel.text = _publishedDate
                }
            }
        }
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.initBackgroundImageView()
//        self.initBackgroundGradient()
//        self.initTitleLabel()
//        self.initPublishedDateLabel()
//        self.initImageDimensionsLabel()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initBackgroundImageView()
        self.initBackgroundGradient()
        self.initTitleLabel()
        self.initPublishedDateLabel()
        self.initImageDimensionsLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = self.bounds
        backgroundGradient.frame = backgroundImageView.bounds
        backgroundImageView.layer.layoutIfNeeded()
        let labelWidth = self.frame.width - (LABEL_MARGINS_X * 2)
        titleLabel.frame = CGRect(x: LABEL_MARGINS_X, y: self.frame.height - (TITLE_LABEL_HEIGHT + OTHER_LABEL_HEIGHT), width: labelWidth, height: TITLE_LABEL_HEIGHT)
        imageDimensionsLabel.frame = CGRect(x: LABEL_MARGINS_X, y: self.frame.height - (OTHER_LABEL_HEIGHT), width: labelWidth, height: TITLE_LABEL_HEIGHT)
    }
    
    fileprivate func initBackgroundImageView() {
        backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(backgroundImageView)
    }
    
    fileprivate func initBackgroundGradient() {
        backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = [transparentColor, opaqueColor]
        backgroundGradient.locations = [0, 1.0]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0.0)
        backgroundGradient.endPoint = CGPoint(x: 0, y: 1.0)
        backgroundImageView.layer.insertSublayer(backgroundGradient, at: 0)
    }
    
    fileprivate func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Arial", size: TITLE_LABEL_FONT_SIZE)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(titleLabel)
    }

    fileprivate func initPublishedDateLabel() {
        publishedDateLabel = UILabel()
        publishedDateLabel.textAlignment = .left
        self.contentView.addSubview(publishedDateLabel)
    }
    
    fileprivate func initImageDimensionsLabel() {
        imageDimensionsLabel = UILabel()
        imageDimensionsLabel.font = UIFont(name: "Arial", size: OTHER_LABEL_FONT_SIZE)
        imageDimensionsLabel.textColor = .white
        imageDimensionsLabel.textAlignment = .left
        imageDimensionsLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(imageDimensionsLabel)
    }
}
