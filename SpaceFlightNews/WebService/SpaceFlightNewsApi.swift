//
//  SpaceFlightNewsApi.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import Foundation
protocol ISpaceFlightNewsApi: AnyObject {
	func fetchNews()
}

public class SpaceFlightNewsApi {
	private weak var parent: IRepository?
	private let apiUrlString = Constants.baseURL

	init(parent: IRepository) {
		self.parent = parent
	}
// MARK: - Private Methods
	func performRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
		guard let url 	= URL(string: urlString) else {return}
		let session 	= URLSession(configuration: .default)
		let request 	= NSURLRequest(url: url)
		let dataTask	= session.dataTask(
			with: request as URLRequest,
			completionHandler: { (data, _, error) -> Void in
				if let error = error {
					self.parent?.didFailWithError(error: error)
					completion(.failure(error))
				} else {
					guard let safeData = data else {return}
					completion(.success(safeData))
				}
			})
		dataTask.resume()
	}
}
// MARK: - ISpaceFlightNewsApi Methods
extension SpaceFlightNewsApi: ISpaceFlightNewsApi {

	func fetchNews() {
		performRequest(with: apiUrlString) { (result) in
			_ = result.map { (data) in
				guard !data.isEmpty else {
					self.parent?.didFailWithError(error: NSError())
					return }
				do {
					try self.parent?.didReceiveData(data)
				} catch {
					self.parent?.didFailWithError(error: NSError())
				}
			}
		}
	}
}
