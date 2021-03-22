//
//  SpaceFlightNewsViewControllerTests.swift
//  SpaceFlightNewsTests
//
//  Created by Ekaterina Khudzhamkulova on 22.3.2021.
//

import XCTest
@testable import SpaceFlightNews

class SpaceFlightNewsViewControllerTests: XCTestCase {
	var sut: SpaceCollectionViewController?

	func makeSUT() -> SpaceCollectionViewController {
		let sut = SpaceCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
		return sut
	}

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
		sut = nil
    }

    func testSendValidUrlToRequestForImage() throws {
		do {
			try sut?.sendRequestForImage(
				newsItemUrl: "https://mk0spaceflightnoa02a.kinstacdn.com/wp-content/uploads/2021/03/50875730681_b4e2d8c6cc_k.jpg",
				newsId: "6051e86631c42cd69c01e29a")
		} catch {
			XCTFail("Failed to unwrap optional image URL string")
		}
	}
	func testDoNotSendInvalidUrlToRequestForImage() throws {
		sut = makeSUT()
		XCTAssertThrowsError(try sut?.sendRequestForImage(newsItemUrl: nil, newsId: "6051e86631c42cd69c01e29a"))
	}
}
