//
//  SpaceCell.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import UIKit
protocol ISpaceCell {
	func setText(text: String)
	func setImage(newImage: UIImage)
}

final class SpaceCell: UICollectionViewCell {
	private let label 			= UILabel(frame: .zero)
	private let newsImage		= UIImageView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor 	= UIColor(red: 0.84, green: 0.85, blue: 0.87, alpha: 1.00)
		setupLabel()
		setupImage()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupLabel() {
		label.numberOfLines = 0
		label.font 			= UIFont.systemFont(ofSize: 24, weight: .bold)
		label.textColor 	= UIColor(red: 0.11, green: 0.14, blue: 0.16, alpha: 1.00)
		self.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints 										= false
		label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive 		= true
		label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive 		= true
		label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive 	= true
	}
	private func setupImage() {
		newsImage.contentMode 	= .scaleAspectFill
		newsImage.clipsToBounds = true
		self.addSubview(newsImage)
		newsImage.translatesAutoresizingMaskIntoConstraints 										= false
		newsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive 				= true
		newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive 		= true
		newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive 	= true
		newsImage.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -4).isActive 		= true
	}
}
extension SpaceCell: ISpaceCell {
	func setText(text: String) {
		label.text = text
	}
	func setImage(newImage: UIImage) {
		newsImage.image = newImage

	}
}
