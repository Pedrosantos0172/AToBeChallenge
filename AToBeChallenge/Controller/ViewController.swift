//
//  ViewController.swift
//  AToBeChallenge
//
//  Created by Pedro Santos on 15/01/2025.
//


import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: - Properties
    let userDefaults = UserDefaults.standard
    private var tableView: UITableView!
    private var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupTableView()
        
        if !UserDefaults.contains("didFetch") {
            fetchProducts()
        }else{
            if userDefaults.bool(forKey: "didFetch") == true{
                if let savedProducts = loadProductsFromUserDefaults() {
                    self.products = savedProducts
                    self.tableView.reloadData()
                }
            }else{
                fetchProducts()
            }
            
        }
        
    }

    private func setupTableView() {
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        view.addSubview(tableView)
        tableView.anchor(centerX: nil, centerY: nil, top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
    }
    
    private func fetchProducts() {
        
        let url = URL(string: "https://dummyjson.com/products?limit=0")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ProductsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching products: \(error)")
                    self.userDefaults.setValue(false, forKey: "didFetch")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.products = response.products
                self?.saveProductsToUserDefaults(products: response.products)
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    private func saveProductsToUserDefaults(products: [Product]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(products) {
            self.userDefaults.set(encoded, forKey: "savedProducts")
            self.userDefaults.setValue(true, forKey: "didFetch")
        }
    }
    
    private func loadProductsFromUserDefaults() -> [Product]? {
        if let savedData = self.userDefaults.data(forKey: "savedProducts") {
            let decoder = JSONDecoder()
            return try? decoder.decode([Product].self, from: savedData)
        }
        return nil
    }

}




// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
    
        // Check rating to select image from the array
        let selectedImageURL: String? = Helpers.shared.checkRating(product: product)
      
        if let urlString = selectedImageURL, let url = URL(string: urlString) {
            cell.iconImageView.load(url: url)
        }
        
        cell.titleLabel.text = "\(product.title)"
        cell.ratingLabel.text = "Rating: \(product.rating)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let controller = DescriptionViewController(product: product)
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pedro Santos - Challenge App"
    }

}
