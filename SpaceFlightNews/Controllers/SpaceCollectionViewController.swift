//
//  SpaceCollectionViewController.swift
//  SpaceFlightNews
//
//  Created by Ekaterina Khudzhamkulova on 13.3.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol ISpaceCollectionViewController {
	func didUpdateList(model: [NewsListElement])
	func didFailWithError(error: Error)
}
final class SpaceCollectionViewController: UICollectionViewController {
	lazy private var repository = Repository(parent: self)
	private var news 			= [NewsListElement]()

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
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(SpaceCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		repository.fetchNews()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {1}

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return news.count
    }

    override func collectionView(
		_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		if let spaceCell = cell as? SpaceCell {
			spaceCell.setText(text: news[indexPath.row].title)
		}
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
