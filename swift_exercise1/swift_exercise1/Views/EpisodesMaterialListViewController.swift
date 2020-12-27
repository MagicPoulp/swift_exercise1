//
//  EpisodesMaterialListViewController.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-27.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit
// https://material.io/components/lists/ios#using-lists
import MaterialComponents.MaterialList

//MARK: Types
struct PodcastShort: Decodable {
    let id: Int
    let title: String
    let created: String
    let description: String
}

struct Episode: Decodable {
    let podcast: PodcastShort
    let id: Int
    let title: String
    let duration: Int
    let created: String
    let description: String
}


class EpisodesCollectionViewController: UICollectionViewController {

    //MARK: Properties
    @IBOutlet var collectionViewInstance: UICollectionView!
    var episodesURL: String = "http://localhost:4200/episodes.json"
    var episodes: Array<Episode> = Array<Episode>()
    let httpManager: HttpManager = HttpManager()

    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }

        //https://stackoverflow.com/questions/32453145/storyboard-static-table-view-too-many-rows
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    //MARK: Data management
    func getData() {
        let callback: (Data) -> Void = { data in
            let episodes: Array<Episode> = try! JSONDecoder().decode([Episode].self, from: data)
            self.episodes = episodes
            self.collectionViewInstance.reloadData()
        }
        httpManager.get(url: self.episodesURL, callback: callback)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData: Episode = episodes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episodesCell", for: indexPath) as! EpisodesViewCell
        cell.index = indexPath.row
        cell.title.text = cellData.title
        cell.title.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.partOfTheDescription.numberOfLines = 2
        cell.partOfTheDescription.adjustsFontSizeToFitWidth = false
        cell.partOfTheDescription.lineBreakMode = .byTruncatingTail
        cell.partOfTheDescription.text = cellData.description
        cell.duration.text = String(cellData.duration) + " min"
        let dateArr = cellData.created.split(separator: "T")
        cell.date.text = "Created: " + String(dateArr[0])
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = ConstantsEnum.lightgray900
        } else {
            cell.backgroundColor = ConstantsEnum.lightgray800
        }
        // https://stackoverflow.com/questions/26895370/uitableviewcell-selected-background-color-on-multiple-selection
        let backgroundView = UIView()
        backgroundView.backgroundColor = ConstantsEnum.teal1
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is EpisodesDetailsViewController
        {
            //https://stackoverflow.com/questions/25369412/swift-pass-data-through-navigation-controller
            let vc = segue.destination as? EpisodesDetailsViewController
            let cell = sender as! EpisodesViewCell
            vc?.episode = episodes[cell.index]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
}

extension EpisodesCollectionViewController: PinterestLayoutDelegate {
  func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    // 4 label heights, top and bottom margins, and 30 in-between spaces
    return 20 * 4 + 20 + 30
  }
}

// large parts of the code was copied from here:
// it is unlicensed in the downloaded content
// https://www.raywenderlich.com/4829472-uicollectionview-custom-layout-tutorial-pinterest
protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
  // 1
  weak var delegate: PinterestLayoutDelegate?

  // 2
  private let numberOfColumns = 1
  private let cellPadding: CGFloat = 0

  // 3
  private var cache: [UICollectionViewLayoutAttributes] = []

  // 4
  private var contentHeight: CGFloat = 0

  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }

  // 5
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
    // 1
    guard
      cache.isEmpty == true,
      let collectionView = collectionView
      else {
        return
    }
    // 2
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    var xOffset: [CGFloat] = []
    for column in 0..<numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    var column = 0
    var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
      
    // 3
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
        
      // 4
      let photoHeight = delegate?.collectionView(
        collectionView,
        heightForPhotoAtIndexPath: indexPath) ?? 180
      let height = cellPadding * 2 + photoHeight
      let frame = CGRect(x: xOffset[column],
                         y: yOffset[column],
                         width: columnWidth,
                         height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
      // 5
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
        
      // 6
      contentHeight = max(contentHeight, frame.maxY)
      yOffset[column] = yOffset[column] + height
        
      column = column < (numberOfColumns - 1) ? (column + 1) : 0
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // Loop through the cache and look for items in the rect
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
}


// https://material.io/components/lists
//class EpisodesViewCell: UICollectionViewCell {
class EpisodesViewCell: MDCBaseCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var partOfTheDescription: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var date: UILabel!
    var index = 0
}
