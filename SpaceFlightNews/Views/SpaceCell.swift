//
//  SpaceCell.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import UIKit
protocol ISpaceCell {
	func setText(text: String)
}

final class SpaceCell: UICollectionViewCell {
	private let label = UILabel(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor(red: 0.84, green: 0.85, blue: 0.87, alpha: 1.00)
		setupLabel()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupLabel() {
		self.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
		label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true

		label.textColor = UIColor(red: 0.11, green: 0.14, blue: 0.16, alpha: 1.00)
	}
}
extension SpaceCell: ISpaceCell {
	func setText(text: String) {
		label.text = text
	}
}
