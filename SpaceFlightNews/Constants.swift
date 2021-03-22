//
//  Constants.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import UIKit

struct Constants {
	static let baseURL 					= "https://test.spaceflightnewsapi.net/api/v2/articles?_limit=7"
	static let reuseIdentifier 			= "collectionCell"
	static let collectionBackGround		= UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
	static let cellBackground			= UIColor(red: 0.84, green: 0.85, blue: 0.87, alpha: 1.00)
	static let summaryFont				= UIFont.systemFont(ofSize: 16, weight: .light)
	static let titleFont				= UIFont.systemFont(ofSize: 24, weight: .bold)
	static let titleTextColor			= UIColor(red: 0.11, green: 0.14, blue: 0.16, alpha: 1.00)
	static let publishedLabelFont		= UIFont.systemFont(ofSize: 10, weight: .light)
}

enum SpaceFlightErrors: Error {
	case errorCreatingUrl
	case parsingNewsListError
	case decodindImageError
	case fetchedEmptyDataError
	case itemUrlIsNil
}
