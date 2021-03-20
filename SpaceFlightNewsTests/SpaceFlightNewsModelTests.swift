//
//  SpaceFlightNewsTests.swift
//  SpaceFlightNewsTests
//
//  Created by Ekaterina Khudzhamkulova on 14.3.2021.
//

import XCTest
@testable import SpaceFlightNews
class SpaceFlightNewsModelTests: XCTestCase {

	override class func setUp() {
		super.setUp()
	}
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testValidCallToAPIGetsHTTPStatusCode200() {
		let session = URLSession(configuration: .default)
		let url 	= URL(string: Constants.baseURL)
		let promise = expectation(description: "Completion handler invoked")
		var statusCode: Int?
		var responseError: Error?

		let dataTask = session.dataTask(with: url!) { _, response, error in
		  statusCode = (response as? HTTPURLResponse)?.statusCode
		  responseError = error
		  promise.fulfill()
		}
		dataTask.resume()
		wait(for: [promise], timeout: 5)

		XCTAssertNil(responseError)
		XCTAssertEqual(statusCode, 200)
	}

	func testJSONParsing() throws {
		let viewController = SpaceCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
		let repository = Repository(parent: viewController)

		guard let fileURL = Bundle.main.url(forResource: "TestJSON", withExtension: "json") else {
			XCTFail("Missing file: TestJSON.json")
			return
		}
		if let data = try? Data(contentsOf: fileURL, options: .alwaysMapped) {
			do {
			try repository.didReceiveData(data)
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
