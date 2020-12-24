//
//  ViewController.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-24.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

//MARK: Types
struct Podcast: Decodable {
    let id: Int
    let title: String
    let numberOfEpisodes: Int
    let created: String
    let description: String
}

class PodcastsViewController: UIViewController {

    //MARK: Properties
    @IBOutlet var podcastsMainStackView: UIStackView!
    
    var podcastViewHeight: CGFloat = 100
    
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

        // a new thread prevent blocking the main thread
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                // as said in the tutorial UI updates must be run on the main thread
                DispatchQueue.main.async {
                    // decoding taken from here:
                    // https://programmingwithswift.com/parse-json-from-file-and-url-with-swift/
                    // use URLSession like in the link above to catch preoperly http errors
                    //let dataJson = data.data(using: .utf8)!
                    let dataJson = data
                    let podcasts: Array<Podcast> = try! JSONDecoder().decode([Podcast].self, from: dataJson)
                    let numPodcasts = podcasts.count;
                    // https://stackoverflow.com/questions/42669554/how-to-update-the-constant-height-constraint-of-a-uiview-programmatically
                    let calculatedHeight: CGFloat = self.podcastViewHeight * CGFloat(numPodcasts)
                    for constraint in self.podcastsMainStackView.constraints {
                        if constraint.identifier == "podcastsMainStackViewHeightConstraint" {
                           constraint.constant = calculatedHeight
                        }
                    }
                    self.podcastsMainStackView.setNeedsDisplay()
                    self.podcastsMainStackView.layoutIfNeeded()

                    for podcast in podcasts {
                        print(podcast.title)
                        self.addPodcastView()
                    }
                    self.podcastsMainStackView.setNeedsDisplay()
                    self.podcastsMainStackView.layoutIfNeeded()
                }
            }
        }
    }
    
    // https://stackoverflow.com/questions/29094129/swift-creating-a-vertical-uiscrollview-programmatically
    func addPodcastView() {
        let view = UIView()
        self.podcastsMainStackView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: self.podcastViewHeight).isActive = true
        //view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //https://developer.apple.com/documentation/uikit/nslayoutanchor
        // Creating constraints using NSLayoutConstraint
        NSLayoutConstraint(item: view,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.podcastsMainStackView,
                           attribute: .leadingMargin,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true

        NSLayoutConstraint(item: view,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.podcastsMainStackView,
                           attribute: .trailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        /*
        NSLayoutConstraint(item: view,
                            attribute: .top,
                            relatedBy: .equal,
                            toItem: self.podcastsMainStackView,
                            attribute: .trailingMargin,
                            multiplier: 1.0,
                            constant: 0.0).isActive = true*/
    }
}

