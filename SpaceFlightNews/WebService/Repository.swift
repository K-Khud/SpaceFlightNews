//
//  Repository.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import UIKit

protocol IRepository: AnyObject {
	// MARK: - Methods called from SpaceViewController
	func fetchNews()
	func getImage(stringUrl: String, newsId: String)
	// MARK: - Methods called from SpaceFlightNewsApi
	func didReceiveData(_ data: Data) throws
	func didReceiveImage(_ data: Data, newsId: String) throws
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
			throw SpaceFlightErrors.parsingNewsListError
		}
		return newsArray
	}
	private func decodeImageFromData(_ data: Data) throws -> UIImage {
		guard let newImage = UIImage(data: data) else {
			throw SpaceFlightErrors.decodindImageError
		}
		return newImage
	}
}
// MARK: - IRepository Methods
extension Repository: IRepository {
	// MARK: - Methods called from SpaceViewController
	func fetchNews() {
		client.fetchNews()
	}
	func getImage(stringUrl: String, newsId: String) {
		client.getImage(stringUrl: stringUrl, newsId: newsId)
	}

	// MARK: - Methods called from SpaceFlightNewsApi
	func didReceiveData(_ data: Data) throws {
			do {
				let news = try parseJsonToNewsList(data)
				parent?.didUpdateList(model: news)
			} catch {
				throw SpaceFlightErrors.parsingNewsListError
		}
	}
	func didReceiveImage(_ data: Data, newsId: String) throws {
		do {
			let newImage = try decodeImageFromData(data)
			parent?.didGetImage(newImage: newImage, newsId: newsId)
		} catch {

		}
	}

	func didFailWithError(error: Error) {
		// TODO: - check for error types
		parent?.didFailWithError(error: error)
	}
}

enum SpaceFlightErrors: Error {
	case parsingNewsListError
	case decodindImageError
	case fetchDataError
	case itemUrlIsNil
}
