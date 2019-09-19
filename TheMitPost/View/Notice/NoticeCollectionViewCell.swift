//
//  NoticeCollectionViewCell.swift
//  TheMitPost
//
//  Created by Harshavardhan K on 18/09/19.
//  Copyright © 2019 Harshavardhan K. All rights reserved.
//

import UIKit
import MaterialComponents

class NoticeImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeImageView: UIImageView!
    
    static let height: CGFloat = 365.0
    static let width: CGFloat = 350.0
    
    var url: URL? {
        
        didSet {
            
            if let url_ = url {
                noticeImageView.sd_setImage(with: url_, completed: nil)
            }
        }
    }
    
    var titleText: String? {
        
        didSet {
            
            if let title_ = titleText {
                titleLabel.text = title_
            }
        }
    }
    
    var contentText: String? {
        
        didSet {
            
            if let content_ = contentText {
                contentLabel.text = content_
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowLayer?.elevation = .cardPickedUp
        
        /*layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 20.0
        layer.shadowRadius = 12.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.7
        //layer.shadowColor = UIColor.gray.cgColor*/
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 5.0
        layer.shadowRadius = 10.0
        
        clipsToBounds = false
        
        noticeImageView.clipsToBounds = true
        noticeImageView.layer.masksToBounds = true
        noticeImageView.clipsToBounds = true
        
        titleLabel.font = MDCTypography.titleFont()
        titleLabel.alpha = MDCTypography.titleFontOpacity()
        
        contentLabel.font = MDCTypography.body1Font()
        contentLabel.alpha = MDCTypography.body1FontOpacity()
    }
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer? {
        return self.layer as? MDCShadowLayer
    }
}

class NoticeTextCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let height: CGFloat = 120.0
    static let width: CGFloat = 350.0
    
    var titleText: String? {
        
        didSet {
            
            if let title_ = titleText {
                titleLabel.text = title_
            }
        }
    }
    
    var contentText: String? {
        
        didSet {
            
            if let content_ = contentText {
                contentLabel.text = content_
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        shadowLayer?.elevation = .cardPickedUp
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 5.0
        layer.shadowRadius = 10.0
        
        /*layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 20.0
        layer.shadowRadius = 12.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.7*/
        
        clipsToBounds = false
        
        titleLabel.font = MDCTypography.titleFont()
        titleLabel.alpha = MDCTypography.titleFontOpacity()
        
        contentLabel.font = MDCTypography.body1Font()
        contentLabel.alpha = MDCTypography.body1FontOpacity()
        
    }
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer? {
        return self.layer as? MDCShadowLayer
    }
    
}

class NoticePDFCollectionViewCell: UICollectionViewCell {
    
}