//
//  SpaceCell.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import UIKit
protocol ISpaceCell {
	func setTitle(text: String)
	func setSummary(text: String, pageUrl: String)
	func setPublishedLabel(text: String)
	func setImage(newImage: UIImage)
}

final class SpaceCell: UICollectionViewCell {
	private let title 			= UILabel(frame: .zero)
	private let publishedLabel	= UILabel(frame: .zero)

	private let summary 		= UITextView(frame: .zero)
	private let newsImage		= UIImageView(frame: .zero)
	private let attributes 		= [
		NSAttributedString.Key.font: Constants.summaryFont,
		NSAttributedString.Key.foregroundColor: UIColor.black
	] as [NSAttributedString.Key: Any]

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor 	= Constants.cellBackground
		setupSummary()
		setupTitle()
		setupPublishedLabel()
		setupImage()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupSummary() {
		summary.isScrollEnabled 		= false
		summary.isEditable				= false
		summary.backgroundColor			= .clear
		summary.dataDetectorTypes 		= .link
		self.addSubview(summary)
		summary.translatesAutoresizingMaskIntoConstraints 										= false
		summary.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive 		= true
		summary.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive 	= true
		summary.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive 	= true
	}
	private func setupTitle() {

		title.numberOfLines = 0
		title.font 			= Constants.titleFont
		title.textColor 	= Constants.titleTextColor
		self.addSubview(title)
		title.translatesAutoresizingMaskIntoConstraints 										= false
		title.bottomAnchor.constraint(equalTo: summary.topAnchor, constant: -4).isActive 		= true
		title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive 		= true
		title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive 	= true
	}
	private func setupPublishedLabel() {
		publishedLabel.numberOfLines 	= 0
		publishedLabel.font 			= Constants.publishedLabelFont
		publishedLabel.textColor 		= .black
		self.addSubview(publishedLabel)
		publishedLabel.translatesAutoresizingMaskIntoConstraints 										= false
		publishedLabel.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -2).isActive 		= true
		publishedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive 	= true
		publishedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive 	= true
	}

	private func setupImage() {
		newsImage.contentMode 	= .scaleAspectFill
		newsImage.clipsToBounds = true
		self.addSubview(newsImage)
		newsImage.translatesAutoresizingMaskIntoConstraints 										= false
		newsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive 				= true
		newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive 		= true
		newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive 	= true
		newsImage.bottomAnchor.constraint(equalTo: publishedLabel.topAnchor, constant: -2).isActive = true
	}
}
extension SpaceCell: ISpaceCell {
	func setTitle(text: String) {
		title.text = text
	}
	func setSummary(text: String, pageUrl: String) {
		let newText = "\(text)\n Details: \(pageUrl)"
		summary.attributedText = NSAttributedString(string: newText, attributes: attributes)
	}
	func setPublishedLabel(text: String) {
		publishedLabel.text = text
	}
	func setImage(newImage: UIImage) {
		newsImage.image = newImage
	}
}
