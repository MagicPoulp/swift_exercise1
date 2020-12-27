//
//  EpisodesDetailsViewController.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-27.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

class EpisodesDetailsViewController: UIViewController {

    var podcast: Podcast? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ConstantsEnum.lightgray900
        /*
        self.detailsTitle.text = podcast?.title
        self.detailsTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.detailsDescription.text = podcast?.description
        self.detailsDescription.numberOfLines = 15
        let numberOfEpisodes: Int = podcast?.numberOfEpisodes ?? -1
        self.detailsNumberOfEpisodes.text = String(numberOfEpisodes) + " episodes"*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Actions

}
