//
//  SpaceFlightNewsWebServiceTest.swift
//  SpaceFlightNewsTests
//
//  Created by Ekaterina Khudzhamkulova on 22.3.2021.
//

import XCTest
@testable import SpaceFlightNews

class SpaceFlightNewsApiServiceTest: XCTestCase {
	let repository 		= RepositoryMock()

	func makeSUT() -> SpaceFlightNewsApi {
		let sut = SpaceFlightNewsApi(parent: repository)
		return sut
	}

	func testValidCallToAPIGetsHTTPStatusCode200() {
		let session = URLSession(configuration: .default)
		let url 	= URL(string: Constants.baseURL)
		let promise = expectation(description: "Completion handler invoked")
		var statusCode: Int?
		var responseError: Error?

		let dataTask = session.dataTask(with: url!) { _, response, error in
		  statusCode 	= (response as? HTTPURLResponse)?.statusCode
		  responseError = error
		  promise.fulfill()
		}
		dataTask.resume()
		wait(for: [promise], timeout: 5)

		XCTAssertNil(responseError)
		XCTAssertEqual(statusCode, 200)
	}
	func testValidImageCallGetsHTTPStatusCode200() throws {
		let session = URLSession(configuration: .default)
		let url 	= URL(string: "https://mk0spaceflightnoa02a.kinstacdn.com/wp-content/uploads/2021/03/lm4cliftoff.jpg")
		let promise = expectation(description: "Completion handler invoked")
		var statusCode: Int?
		var responseError: Error?

		let dataTask = session.dataTask(with: url!) { _, response, error in
		  statusCode 	= (response as? HTTPURLResponse)?.statusCode
		  responseError = error
		  promise.fulfill()
		}
		dataTask.resume()
		wait(for: [promise], timeout: 5)

		XCTAssertNil(responseError)
		XCTAssertEqual(statusCode, 200)
	}

	func testPerformRequestReturnsValid() {
		let sut 		= makeSUT()
		let promise 	= expectation(description: "Completion handler invoked")
		var data: Data?

		sut.performRequest(with: Constants.baseURL) { (result) in
			do {
				data = try result.get()
				promise.fulfill()
			} catch {
				XCTFail("data is nil")
			}
		}
		wait(for: [promise], timeout: 5)
		XCTAssertNotNil(data)
	}
}
