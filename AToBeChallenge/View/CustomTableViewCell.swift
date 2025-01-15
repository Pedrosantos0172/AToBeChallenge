//
//  CustomTableViewCell.swift
//  AToBeChallenge
//
//  Created by Pedro Santos on 15/01/2025.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
       let txtLabel = UILabel()
        txtLabel.textColor = .darkGray
        txtLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 18)
        return txtLabel
    }()
    
    let ratingLabel: UILabel = {
       let txtLabel = UILabel()
        txtLabel.textColor = .darkGray
        txtLabel.font = UIFont(name: "TrebuchetMS-Regular", size: 14)
        return txtLabel
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImageView)
        iconImageView.anchor(centerX: nil, centerY: self.centerYAnchor, top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: .zero, left: 10.0, bottom: .zero, right: .zero), size: CGSize(width: 50.0, height: 50.0))
        
        addSubview(titleLabel)
        titleLabel.anchor(centerX: nil, centerY: nil, top: self.topAnchor, leading: iconImageView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10.0, left: 10.0, bottom: .zero, right: 10.0), size: CGSize(width: .zero, height: 20.0))
        
        addSubview(ratingLabel)
        ratingLabel.anchor(centerX: nil, centerY: nil, top: nil, leading: iconImageView.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: .zero, left: 10.0, bottom: 10.0, right: 10.0), size: CGSize(width: .zero, height: 20.0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been impleented")
    }

}
