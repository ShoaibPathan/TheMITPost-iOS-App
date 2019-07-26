//
//  ArticleHeaderViewTableViewCell.swift
//  TheMitPost
//
//  Created by Harshavardhan K on 21/03/19.
//  Copyright © 2019 Harshavardhan K. All rights reserved.
//

import UIKit
import UIImageColors

class ArticleHeaderViewTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var authorLabelView: UILabel!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    
    var article: Article! {
        
        didSet {
            
            featuredImageView.sd_setImage(with: URL(string: article.featured_media!), completed: nil)
            
            titleLabelView.text = article.title
            authorLabelView.text = "By " + article.author.uppercased()
            
            featuredImageView.image!.getColors {
                colors in
                
                //self.backgroundView?.backgroundColor = colors.background
                self.titleLabelView.textColor = colors?.primary ?? UIColor.black
                self.authorLabelView.textColor = colors?.background ?? UIColor.black
                
                
            }
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabelView.lineBreakMode = .byWordWrapping
        titleLabelView.numberOfLines = 0
        
        titleLabelView.font = UIFont(name: "Optima", size: 22)
        authorLabelView.font = UIFont(name: "Optima", size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}