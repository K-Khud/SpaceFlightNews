//
//  Constants.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import Foundation

struct Constants {
	static let baseURL 					= "https://test.spaceflightnewsapi.net/api/v2/articles?_limit=7"
	static let reuseIdentifier 			= "collectionCell"
}

enum SpaceFlightErrors: Error {
	case parsingNewsListError
	case decodindImageError
	case fetchDataError
	case itemUrlIsNil
}
