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
    @IBOutlet var podcastsMainStackView: UIStackView!
    
    var podcastViewHeight: CGFloat = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }

    //MARK: Data management
    // https://cocoacasts.com/fm-3-download-an-image-from-a-url-in-swift
    func getData() {
        // Create URL
        // here is how to make it work on HTTPS with more work:
        // https://jaanus.com/ios-13-certificates/
        let url = URL(string: "http://localhost:4200/podcasts.json")!

        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                // as said in the tutorial UI updates must be run on the main thread
                DispatchQueue.main.async {
                    let numPodcasts = 3;
                    self.podcastsMainStackView.addSubview(self.podcastView())
                    let calculatedHeight: CGFloat = self.podcastViewHeight * CGFloat(numPodcasts)
                    https://stackoverflow.com/questions/42669554/how-to-update-the-constant-height-constraint-of-a-uiview-programmatically
                    for constraint in self.podcastsMainStackView.constraints {
                        if constraint.identifier == "podcastsMainStackViewHeightConstraint" {
                           constraint.constant = calculatedHeight
                        }
                    }
                    self.podcastsMainStackView.layoutIfNeeded()
                    
                }
            }
        }
    }
    
    // https://stackoverflow.com/questions/29094129/swift-creating-a-vertical-uiscrollview-programmatically
    func podcastView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: self.podcastViewHeight).isActive = true
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        view.backgroundColor = .white
        return view
    }
}

