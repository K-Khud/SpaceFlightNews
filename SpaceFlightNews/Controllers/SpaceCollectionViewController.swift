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
	lazy private var repository	 	= Repository(parent: self)
	private var news 				= [NewsListElement]()
	private var newsImages			= [String: UIImage]()

	lazy var alert: UIAlertController = {
		let alert = UIAlertController(
			title: "Error",
			message: "Empty data in server response.",
			preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { _ in
			self.repository.fetchNews()
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
		return alert
	}()

	init(collectionViewLayout layout: UICollectionViewFlowLayout) {
		super.init(collectionViewLayout: layout)
		layout.scrollDirection 			= .vertical
		collectionView.backgroundColor 	= Constants.collectionBackGround
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		view.accessibilityIdentifier = "onboardingView"
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
			spaceCell.setTitle(text: news[indexPath.row].title)
			spaceCell.setSummary(text: news[indexPath.row].summary ?? "no summary", pageUrl: news[indexPath.row].url ?? "")
			spaceCell.setPublishedLabel(text: news[indexPath.row].publishedAt ?? "")
			spaceCell.accessibilityIdentifier = "newsTitle"

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

	func sendRequestForImage(newsItemUrl: String?, newsId: String) throws {
		guard let itemUrl = newsItemUrl, !itemUrl.isEmpty else {
			throw SpaceFlightErrors.itemUrlIsNil
		}
		repository.getImage(stringUrl: itemUrl, newsId: newsId)
	}
}
extension SpaceCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
						_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let summaryTextView 	= UITextView(frame: .zero)
		summaryTextView.text 	= "\(news[indexPath.row].summary ?? "") \n \(news[indexPath.row].url ?? "")"
		summaryTextView.font 	= Constants.summaryFont
		let summaryHeight 		= summaryTextView.frame.height
		return CGSize(width: view.frame.width, height: 500.0 + summaryHeight)
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
		DispatchQueue.main.async {
			self.present(self.alert, animated: true, completion: nil)
		}
	}
}
