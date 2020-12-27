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
        cell.date.text = String(cellData.created)
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

}

//class EpisodesViewCell: UICollectionViewCell {
class EpisodesViewCell: MDCBaseCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var partOfTheDescription: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var date: UILabel!
    var index = 0
}
