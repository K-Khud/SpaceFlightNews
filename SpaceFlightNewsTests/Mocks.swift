//
//  Mocks.swift
//  SpaceFlightNewsTests
//
//  Created by Ekaterina Khudzhamkulova on 22.3.2021.
//

import UIKit
@testable import SpaceFlightNews

class RepositoryMock: IRepository {
	func fetchNews() {
	}

	func getImage(stringUrl: String, newsId: String) {
	}

	func didReceiveData(_ data: Data) throws {
	}

	func didReceiveImage(_ data: Data, newsId: String) throws {
	}

	func didFailWithError(error: Error) {
	}
}
class ViewControllerMock: ISpaceCollectionViewController {
	func didUpdateList(model: [NewsListElement]) {
	}
	func didGetImage(newImage: UIImage, newsId: String) {
	}
	func didFailWithError(error: Error) {
	}
}
