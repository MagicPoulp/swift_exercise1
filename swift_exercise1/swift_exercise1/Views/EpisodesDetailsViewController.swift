//
//  EpisodesDetailsViewController.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-27.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

class EpisodesDetailsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var podcastLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var date: UILabel!
    var episode: Episode? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ConstantsEnum.lightgray900

        titleLabel.text = episode?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        podcastLabel.text = "Podcast: " + (episode?.podcast.title ?? "")
        descriptionLabel.text = episode?.description
        descriptionLabel.numberOfLines = 1000
        duration.text = String(episode?.duration ?? 0) + " min"
        let dateArr = episode?.created.split(separator: "T")
        date.text = "Created: " + String(dateArr?[0] ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Actions

}
