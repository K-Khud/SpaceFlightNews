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
	private func performRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
		if let url = URL(string: urlString) {
			let session = URLSession(configuration: .default)
			let request = NSMutableURLRequest(url: url,
											  cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
											  timeoutInterval: 60.0)
			request.httpMethod = "GET"
			let dataTask = session.dataTask(with: request as URLRequest,
											completionHandler: { (data, _, error) -> Void in
												if let error = error {
													self.parent?.didFailWithError(error: error)
													completion(.failure(error))
												} else {
													if let safeData = data {
														completion(.success(safeData))
													}
												}
											})
			dataTask.resume()
		}
	}
}
// MARK: - ISpaceFlightNewsApi Methods
extension SpaceFlightNewsApi: ISpaceFlightNewsApi {
	func fetchNews() {
		performRequest(with: apiUrlString) { (result) in
			_ = result.map { (data) in
				if data.isEmpty {
					self.parent?.didFailWithError(error: NSError())
				} else {
					self.parent?.didReceiveData(data)
				}
			}
		}
	}
}
