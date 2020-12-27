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

        view.backgroundColor = ConstantsEnum.lightgray900
        detailsTitle.text = podcast?.title
        detailsTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        detailsDescription.text = podcast?.description
        detailsDescription.numberOfLines = 15
        let numberOfEpisodes: Int = podcast?.numberOfEpisodes ?? -1
        detailsNumberOfEpisodes.text = String(numberOfEpisodes) + " episodes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Actions

}
