//
//  Repository.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import Foundation

protocol IRepository: AnyObject {
	// MARK: - Methods called from SpaceViewController
	func fetchNews()
	// MARK: - Methods called from SpaceFlightNewsApi
	func didReceiveData(_ data: Data) throws
	// Error handling
	func didFailWithError(error: Error)
}
class Repository {
	private var parent: ISpaceCollectionViewController?
	private lazy var client 			= SpaceFlightNewsApi(parent: self)

	init(parent: ISpaceCollectionViewController?) {
		self.parent 					= parent
	}
	private func parseJsonToNewsList(_ data: Data) throws -> [NewsListElement] {
		var newsArray 	= [NewsListElement]()
		let decoder 	= JSONDecoder()
		do {
			let decodedData = try decoder.decode([NewsListElement].self, from: data)
			decodedData.forEach { (item) in
				let newsItem = NewsListElement(id: item.id,
											   title: item.title,
											   url: item.url,
											   imageURL: item.imageURL,
											   newsSite: item.newsSite,
											   summary: item.summary,
											   publishedAt: item.publishedAt,
											   updatedAt: item.updatedAt,
											   featured: item.featured,
											   launches: item.launches,
											   events: item.events)
				newsArray.append(newsItem)
			}
		} catch {
			parent?.didFailWithError(error: error)
			throw SpaceFlightErrors.parsingError
		}
		return newsArray
	}
}
// MARK: - IRepository Methods
extension Repository: IRepository {

	// MARK: - Methods called from SpaceViewController
	func fetchNews() {
		client.fetchNews()
	}

	// MARK: - Methods called from SpaceFlightNewsApi
	func didReceiveData(_ data: Data) throws {
			do {
				let news = try parseJsonToNewsList(data)
				parent?.didUpdateList(model: news)
			} catch {
				throw SpaceFlightErrors.parsingError
		}
	}
	func didFailWithError(error: Error) {
		parent?.didFailWithError(error: error)
	}
}

enum SpaceFlightErrors: Error {
	case parsingError
}
