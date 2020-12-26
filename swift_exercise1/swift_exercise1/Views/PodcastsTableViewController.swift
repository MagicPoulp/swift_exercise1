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

class PodcastsTableViewController: UITableViewController {

    //MARK: Properties
    @IBOutlet var tableViewInstance: UITableView!
    var podcastsURL: String = "http://localhost:4200/podcasts.json"
    var podcasts: Array<Podcast> = Array<Podcast>()

    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://stackoverflow.com/questions/32453145/storyboard-static-table-view-too-many-rows
        tableViewInstance.tableFooterView = UIView(frame: .zero)
        getData()
    }

    //MARK: Data management
    // we could use a library (like Refit, or RetrofireSwift), but it is also a security concern to trust the library
    // and I do not have time to check the libraries
    // we also need a better way to react to errors and display errors
    // maybe this could be moved to a delegate
    // https://cocoacasts.com/fm-3-download-an-image-from-a-url-in-swift
    func getData() {
        // Create URL
        // here is how to make it work on HTTPS with more work:
        // https://jaanus.com/ios-13-certificates/
        let url = URL(string: self.podcastsURL)!

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
                    var podcasts: Array<Podcast> = try! JSONDecoder().decode([Podcast].self, from: dataJson)
                    while (podcasts.count < 30) {
                        podcasts.append(podcasts[0])
                    }
                    self.podcasts = podcasts
                    self.tableViewInstance.reloadData()
                    print("count when loaded", podcasts.count)
                }
            }
        }
    }

    func addPodcasts(podcasts: Array<Podcast>) {
        //tableView.dataSource = podcasts!
    }

    /*
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

                    var index = 0;
                    for podcast in podcasts {
                        self.addPodcastView(index: index)
                        index += 1
                    }
                    self.podcastsMainStackView.setNeedsDisplay()
                    self.podcastsMainStackView.layoutIfNeeded()
                }
            }
        }
    }
    
    // https://stackoverflow.com/questions/29094129/swift-creating-a-vertical-uiscrollview-programmatically
    func addPodcastView(index: Int) {
        let view = UIView()
        // arranged is much better and should be fixed
        //self.podcastsMainStackView.addArrangedSubview(view)
        self.podcastsMainStackView.addSubview(view)
        // when doing manual setups, it seems we need this line below
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: self.podcastViewHeight).isActive = true
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

        // it seems that translatesAutoresizingMaskIntoConstraints = false
        // removes the automatic behaviour of the StackView
        NSLayoutConstraint(item: view,
                            attribute: .top,
                            relatedBy: .equal,
                            toItem: self.podcastsMainStackView,
                            attribute: .topMargin,
                            multiplier: 1.0,
                            constant: (self.podcastViewHeight + self.podcastViewSpacing) * CGFloat(index)).isActive = true
    }
    */
    
    // Default cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: Podcast = podcasts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastsCell")! as! PodcastsTableViewCell
        print("text" + cellData.title)
        cell.title.text = cellData.title

        return cell;
    }
    
    // Define no of rows in your tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
}
/*
extension PodcastsViewController: UITableViewDataSource, UITableViewDelegate {
    // Default cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: Podcast = podcasts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        //cell.title = cellData.title

        return cell;
    }
    
    // Define no of rows in your tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count" + String(podcasts.count))
        return podcasts.count
    }

}*/

/*
 https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/CreateATableView.html
 */
// a bug in a specific version of XCode 11.7 seems to block
// the assistant from detecting the class if in a separate file
// but it works for the controller
class PodcastsTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
