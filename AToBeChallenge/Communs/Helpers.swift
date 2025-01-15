//
//  Helpers.swift
//  AToBeChallenge
//
//  Created by Pedro Santos on 15/01/2025.
//

import Foundation

class Helpers {
    
    static let shared: Helpers = {
        let shared = Helpers()
        return shared
    }()
    

    func checkRating(product: Product) -> String {
        
        // Check rating to select image from the array
        var selectedImageURL: String?
        if product.rating < 3 {
            selectedImageURL = product.images.first
        }else if product.rating >= 3 && product.rating <= 4 {
            selectedImageURL = product.images.count > 1 ? product.images[1] : product.images.first
        }else {
            selectedImageURL = product.images.last
        }
        
        return selectedImageURL ?? ""
        
    }
    
}
