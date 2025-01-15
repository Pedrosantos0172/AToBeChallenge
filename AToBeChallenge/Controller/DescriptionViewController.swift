//
//  DescriptionViewController.swift
//  AToBeChallenge
//
//  Created by Pedro Santos on 15/01/2025.
//

import Foundation
import UIKit

class DescriptionViewController: UIViewController {
    
    // MARK: - Properties
    let product: Product
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
       let txtLabel = UILabel()
        txtLabel.textColor = .darkGray
        txtLabel.font = UIFont(name: "TrebuchetMS-Regular", size: 18)
        txtLabel.numberOfLines = 2
        txtLabel.lineBreakMode = .byWordWrapping
        return txtLabel
    }()
    
    let ratingLabel: UILabel = {
        let txtLabel = UILabel()
        txtLabel.textColor = .darkGray
        txtLabel.font = UIFont(name: "TrebuchetMS-Regular", size: 14)
        return txtLabel
    }()
    
    let priceLabel: UILabel = {
        let txtLabel = UILabel()
        txtLabel.textColor = .darkGray
        txtLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 40)
        txtLabel.textAlignment = .right
        return txtLabel
    }()
    
    let discountLabel: UILabel = {
        let txtLabel = UILabel()
        txtLabel.textColor = .red
        txtLabel.font = UIFont(name: "TrebuchetMS-Italic", size: 14)
        return txtLabel
    }()
    
    let stockLabel: UILabel = {
        let txtLabel = UILabel()
        txtLabel.textColor = .darkGray
        txtLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 14)
        return txtLabel
    }()
    
    let descriptionLabel: UILabel = {
        let txtLabel = UILabel()
        txtLabel.textColor = .darkGray
        txtLabel.font = UIFont(name: "TrebuchetMS-Regular", size: 14)
        txtLabel.numberOfLines = 0
        
        return txtLabel
    }()
    
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Product Detail"
        setupView()
    }
    
    func setupView() {
        
        var selectedImageURL: String?
        if product.rating < 3 {
            selectedImageURL = product.images.first
        }else if product.rating >= 3 && product.rating <= 4 {
            selectedImageURL = product.images.count > 1 ? product.images[1] : product.images.first
        }else {
            selectedImageURL = product.images.last
            
        }
      
        if let urlString = selectedImageURL, let url = URL(string: urlString) {
            // Fetch the appropriate image asynchronously
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
        view.addSubview(imageView)
        imageView.anchor(centerX: nil, centerY: nil, top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 80.0, left: 20.0, bottom: .zero, right: .zero), size: CGSize(width: 150.0, height: 150.0))
        
        titleLabel.text = product.title
        view.addSubview(titleLabel)
        titleLabel.anchor(centerX: nil, centerY: nil, top: view.topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 80.0, left: 10.0, bottom: .zero, right: 20.0), size: CGSize(width: .zero, height: 50.0))
        
        ratingLabel.text = "Rating: \(product.rating)"
        view.addSubview(ratingLabel)
        ratingLabel.anchor(centerX: nil, centerY: nil, top: titleLabel.bottomAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10.0, left: 10.0, bottom: .zero, right: 10.0), size: CGSize(width: .zero, height: 20.0))
        
        priceLabel.text = "\(product.price) €"
        view.addSubview(priceLabel)
        priceLabel.anchor(centerX: nil, centerY: nil, top: imageView.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10.0, left: 10.0, bottom: .zero, right: 20.0), size: CGSize(width: 180.0, height: 100.0))
        
        discountLabel.text = "Discount: \(product.discountPercentage)%"
        view.addSubview(discountLabel)
        discountLabel.anchor(centerX: nil, centerY: nil, top: imageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 40.0, left: 20.0, bottom: .zero, right: 20.0), size: CGSize(width: .zero, height: 20.0))
        
        stockLabel.text = "Quant.: \(product.stock)"
        view.addSubview(stockLabel)
        stockLabel.anchor(centerX: nil, centerY: nil, top: discountLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10.0, left: 20.0, bottom: .zero, right: 20.0), size: CGSize(width: .zero, height: 20.0))
        
        descriptionLabel.text = "\(product.description)"
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(centerX: nil, centerY: nil, top: stockLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 40.0, left: 20.0, bottom: 10.0, right: 20.0))
        
    }
    
}
