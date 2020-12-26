//
//  PodcastsDetailsViewController.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-26.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

class PodcastsDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func podcastsDetailsBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
