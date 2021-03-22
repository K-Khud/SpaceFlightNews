//
//  SpaceFlightNewsApi.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import Foundation
protocol ISpaceFlightNewsApi: AnyObject {
	func fetchNews()
	func getImage(stringUrl: String, newsId: String)
}

public class SpaceFlightNewsApi {
	private weak var parent: IRepository?
	private let apiUrlString = Constants.baseURL

	init(parent: IRepository) {
		self.parent = parent
	}
// MARK: - Private Methods
	func performRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
		let session 	= URLSession(configuration: .default)
		do {
			let url 		= try createUrl(from: urlString)
			let request 	= NSURLRequest(url: url)
			let dataTask	= session.dataTask(
				with: request as URLRequest,
				completionHandler: { (data, _, error) -> Void in
					if let error = error {
						completion(.failure(error))
					} else {
						guard let safeData = data else {return}
						completion(.success(safeData))
					}
				})
			dataTask.resume()
		} catch {
			parent?.didFailWithError(error: error)
		}
	}
	func createUrl(from string: String) throws -> URL {
		guard let url 	= URL(string: string) else {
			throw SpaceFlightErrors.errorCreatingUrl
		}
		return url
	}
}
// MARK: - ISpaceFlightNewsApi Methods
extension SpaceFlightNewsApi: ISpaceFlightNewsApi {
	func getImage(stringUrl: String, newsId: String) {
		performRequest(with: stringUrl) { (result) in
			_ = result.map({ (data) in
				guard !data.isEmpty else {
					self.parent?.didFailWithError(error: SpaceFlightErrors.fetchedEmptyDataError)
					return }
				do {
					try self.parent?.didReceiveImage(data, newsId: newsId)
				} catch {
					self.parent?.didFailWithError(error: error)
				}
			})
		}
	}

	func fetchNews() {
		performRequest(with: apiUrlString) { (result) in
			_ = result.map { (data) in
				guard !data.isEmpty else {
					self.parent?.didFailWithError(error: SpaceFlightErrors.fetchedEmptyDataError)
					return }
				do {
					try self.parent?.didReceiveData(data)
				} catch {
					self.parent?.didFailWithError(error: error)
				}
			}
		}
	}
}
