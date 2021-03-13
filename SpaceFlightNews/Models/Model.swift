//
//  Model.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import Foundation
// MARK: - NewsListElement
struct NewsListElement {
	let id, title: String
	let url: String
	let imageURL: String
	let newsSite, summary, publishedAt, updatedAt: String
	let featured: Bool
	let launches: [Launch]
	let events: [Any?]
}

// MARK: - Launch
struct Launch {
	let id, provider: String
}
