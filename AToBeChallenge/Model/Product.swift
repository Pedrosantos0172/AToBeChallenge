//
//  Product.swift
//  AToBeChallenge
//
//  Created by Pedro Santos on 15/01/2025.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let thumbnail: String
    let images: [String]
    var imageData: Data?
}

struct ProductsResponse: Codable {
    let products: [Product]
}
