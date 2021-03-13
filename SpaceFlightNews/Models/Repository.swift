//
//  Repository.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import Foundation

protocol IRepository: AnyObject {
	// MARK: - Methods called from SpaceViewController
	func fetchNews(category: String)
	// MARK: - Methods called from ApiClient
	// Loads up the initial list with all products per category
	func didUpdateList(model: [NewsListElement])
	// Error handling
	func didFailWithError(error: Error)
}
class Repository {
	private var parent: ICategoryViewController?
	private lazy var client 			= BadApiClient(parent: self)
	private lazy var productsCache 		= ProductsCache(parent: self)
	private lazy var availabilityCache 	= AvailabilityCache(parent: self)

	private let category: String

	init(parent: ICategoryViewController?, category: String) {
		self.parent 	= parent
		self.category	= category
	}
	deinit {
		print("repository deinit")
	}
}
// MARK: - IRepository Methods
extension Repository: IRepository {
	// MARK: - Methods called from CategoryViewController
	func fetchProducts(category: String) {
		if let products = productsCache.getProductsFromCache(for: category) {
			parent?.didUpdateList(model: products)

		} else {
			client.fetchProducts(category: category)
		}
	}

	func fetchAvailability(for product: Product) {
		if let availability = availabilityCache.getProductAvailability(for: product.id) {

			parent?.didUpdateProduct(model: Product(
										id: product.id,
										type: product.type,
										name: product.name,
										color: product.color,
										price: product.price,
										manufacturer: product.manufacturer,
										availability: availability))

		} else {
			client.fetchAvailability(for: product)
		}
	}
	// MARK: - Methods called from BadApiClient
	func didUpdateList(model: Products) {
		parent?.didUpdateList(model: model)

		DispatchQueue.main.async {
			self.productsCache.updateCache(with: model, category: self.category)
		}
	}

	func didUpdateProduct(model: Product) {
		parent?.didUpdateProduct(model: model)
	}
	func saveAvailability(for manufacturer: ManufacturerFile) {
		DispatchQueue.main.async {
			self.availabilityCache.updateCache(for: manufacturer)
		}
	}

	func didFailWithError(error: Error) {
		parent?.didFailWithError(error: error)
	}
}
