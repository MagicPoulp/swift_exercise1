//
//  PodcastsDetailsViewController.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-26.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

class PodcastsDetailsViewController: UIViewController {

    @IBOutlet var detailsTitle: UILabel!
    @IBOutlet var detailsDescription: UILabel!
    @IBOutlet var detailsNumberOfEpisodes: UILabel!
    var podcast: Podcast? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ConstantsEnum.lightgray900
        self.detailsTitle.text = podcast?.title
        self.detailsTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.detailsDescription.text = podcast?.description
        self.detailsDescription.numberOfLines = 15
        let numberOfEpisodes: Int = podcast?.numberOfEpisodes ?? -1
        self.detailsNumberOfEpisodes.text = String(numberOfEpisodes) + " episodes"
        
    }

    // MARK: - Actions

    @IBAction func podcastsDetailsBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
