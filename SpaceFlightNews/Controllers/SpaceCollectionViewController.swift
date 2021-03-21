//
//  SpaceCollectionViewController.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import UIKit

protocol ISpaceCollectionViewController {
	func didUpdateList(model: [NewsListElement])
	func didGetImage(newImage: UIImage, newsId: String)
	func didFailWithError(error: Error)
}
final class SpaceCollectionViewController: UICollectionViewController {
	lazy private var repository = Repository(parent: self)
	private var news 			= [NewsListElement]()
	private var newsImages		= [String: UIImage]()

	init(collectionViewLayout layout: UICollectionViewFlowLayout) {
		super.init(collectionViewLayout: layout)
		layout.scrollDirection 			= .vertical
		collectionView.backgroundColor 	= UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

		self.collectionView!.register(SpaceCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
		repository.fetchNews()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {1}

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return news.count
    }

    override func collectionView(
		_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath)
		if let spaceCell = cell as? SpaceCell {
			spaceCell.setText(text: news[indexPath.row].title)
			let itemId = news[indexPath.row].id
			if let newImage = newsImages[itemId] {
				spaceCell.setImage(newImage: newImage)
			}
		}
        return cell
    }

	override func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

		let itemId = news[indexPath.row].id
		if newsImages[itemId] == nil {
			do {
				try sendRequestForImage(newsItemUrl: news[indexPath.row].imageURL, newsId: news[indexPath.row].id)
			} catch {
				didFailWithError(error: error)
			}
		}
	}

	private func sendRequestForImage(newsItemUrl: String?, newsId: String) throws {
		guard let itemUrl = newsItemUrl else {
			throw SpaceFlightErrors.itemUrlIsNil
		}
		repository.getImage(stringUrl: itemUrl, newsId: newsId)
	}
}
extension SpaceCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
						_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: 300.0)
	}
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {5.0}
}

extension SpaceCollectionViewController: ISpaceCollectionViewController {
	func didGetImage(newImage: UIImage, newsId: String) {
		DispatchQueue.main.async {
			self.newsImages[newsId] = newImage
			self.collectionView.reloadData()
		}
	}

	func didUpdateList(model: [NewsListElement]) {
		news = model
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}

	func didFailWithError(error: Error) {
		print(error.localizedDescription)
	}
}
