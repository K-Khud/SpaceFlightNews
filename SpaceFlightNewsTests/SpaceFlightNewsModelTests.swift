//
//  SpaceFlightNewsModelTests.swift
//  SpaceFlightNewsTests
//
//  Created by Ekaterina Khudzhamkulova on 22.3.2021.
//

import XCTest
@testable import SpaceFlightNews

class SpaceFlightNewsModelTests: XCTestCase {
	let firstElement = NewsListElement(
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
	let secondElement = NewsListElement(
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
	let thirdElement = NewsListElement(
		id: "testId",
		title: "",
		url: "testUrl",
		imageURL: "testImageUrl",
		newsSite: "newsSite",
		summary: "summary",
		publishedAt: "publishedAt",
		updatedAt: "updatedAt",
		featured: false,
		launches: [Launch(id: "launchTestId", provider: "launchTestProvider")],
		events: nil)

    func testIsTwoNewsItemEqual() throws {
		let isEqual = firstElement == secondElement
		XCTAssertTrue(isEqual)
	}

	func testIsTwoNewsItemIsNotEqual() throws {
		let isEqual = firstElement == thirdElement
		XCTAssertFalse(isEqual)
	}
}
