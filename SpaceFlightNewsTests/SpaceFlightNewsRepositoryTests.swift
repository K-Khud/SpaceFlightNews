//
//  SpaceFlightNewsTests.swift
//  SpaceFlightNewsTests
//
//  Created by Ekaterina Khudzhamkulova on 14.3.2021.
//

import XCTest
@testable import SpaceFlightNews

class SpaceFlightNewsRepositoryTests: XCTestCase {
	let viewController = ViewControllerMock()
	var sut: Repository?

	func makeSUT() -> Repository {
		let sut = Repository(parent: viewController)
		return sut
	}

	override class func setUp() {
		super.setUp()
	}
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
		sut = nil
    }

	func testJSONParsing() throws {
		sut = makeSUT()

		guard let fileURL 	= Bundle.main.url(forResource: "TestJSON", withExtension: "json") else {
			XCTFail("Missing file: TestJSON.json")
			return
		}
		if let data = try? Data(contentsOf: fileURL, options: .alwaysMapped) {
			do {
				try sut!.didReceiveData(data)
			} catch {
				XCTFail("Failed to parse test json")
			}
		} else {
			XCTFail("Failed to get data from TestJSON file")
		}
	}

	func testNewsItemCoding() throws {
		let newsItem = NewsListElement(
			id: "testId",
			title: "testTitle",
			url: "testUrl",
			imageURL: "testImageUrl",
			newsSite: "newsSite",
			summary: "summary",
			publishedAt: "publishedAt",
			updatedAt: "updatedAt",
			featured: false,
			launches: [Launch(id: "launchTestId", provider: "launchTestProvider")],
			events: nil)
		let data = try JSONEncoder().encode(newsItem)
		let decodedNewsItem = try JSONDecoder().decode(NewsListElement.self, from: data)

		XCTAssertEqual(newsItem, decodedNewsItem)
	}

	func testImageDecoding() throws {
		sut = makeSUT()

		guard let fileURL 	= Bundle.main.url(forResource: "TestImage", withExtension: "jpeg") else {
			XCTFail("Missing file: TestImage.jpeg")
			return
		}
		if let data = try? Data(contentsOf: fileURL, options: .alwaysMapped) {
			do {
			try sut!.didReceiveImage(data, newsId: "testId")
			} catch {
				XCTFail("Failed to decode test image")
			}
		} else {
			XCTFail("Failed to get data from data file")
		}
	}
}
