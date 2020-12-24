//
//  ViewController.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-24.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

class PodcastsViewController: UIViewController {

    //MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }

    //MARK: Data management
    // https://cocoacasts.com/fm-3-download-an-image-from-a-url-in-swift
    func getData() {
        // Create URL
        let url = URL(string: "https://localhost:4200/podcasts.json")!

        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    print("done")
                    //self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}

