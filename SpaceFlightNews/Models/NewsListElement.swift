//
//  Model.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import Foundation

// MARK: - NewsListElement
struct NewsListElement: Codable, Equatable {

	let id, title: String
	let url: String?
	let imageURL: String?
	let newsSite, summary, publishedAt, updatedAt: String?
	let featured: Bool?
	let launches: [Launch]?
	let events: [JSONAny]?

	enum CodingKeys: String, CodingKey {
		case id, title, url
		case imageURL
		case newsSite, summary, publishedAt, updatedAt, featured, launches, events
	}
	static func == (lhs: NewsListElement, rhs: NewsListElement) -> Bool {
		if lhs.id == rhs.id,
		   lhs.title == rhs.title,
		   lhs.imageURL == rhs.imageURL,
		   lhs.newsSite == rhs.newsSite,
		   lhs.summary == rhs.summary,
		   lhs.publishedAt == rhs.publishedAt,
		   lhs.updatedAt == rhs.updatedAt,
		   lhs.featured == rhs.featured,
		   lhs.launches == rhs.launches {
			return true
		}
		return false
	}
}

// MARK: - Launch
struct Launch: Codable, Equatable {
	let id, provider: String?
}
