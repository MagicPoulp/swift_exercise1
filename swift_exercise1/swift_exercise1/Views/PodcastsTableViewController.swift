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
                    let podcasts: Array<Podcast> = try! JSONDecoder().decode([Podcast].self, from: dataJson)
                    self.podcasts = podcasts
                    self.tableViewInstance.reloadData()
                }
            }
        }
    }

    func addPodcasts(podcasts: Array<Podcast>) {
        //tableView.dataSource = podcasts!
    }

    // Definition of the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: Podcast = podcasts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastsCell")! as! PodcastsTableViewCell
        cell.index = indexPath.row
        cell.title.text = cellData.title
        cell.title.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.partOfTheDescription.numberOfLines = 2
        cell.partOfTheDescription.adjustsFontSizeToFitWidth = false
        cell.partOfTheDescription.lineBreakMode = .byTruncatingTail
        cell.partOfTheDescription.text = cellData.description
        cell.numberOfEpisodes.text = String(cellData.numberOfEpisodes) + " episodes"
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = ConstantsEnum.lightgray900
        } else {
            cell.backgroundColor = ConstantsEnum.lightgray800
        }
        // https://stackoverflow.com/questions/26895370/uitableviewcell-selected-background-color-on-multiple-selection
        let backgroundView = UIView()
        backgroundView.backgroundColor = ConstantsEnum.teal1
        cell.selectedBackgroundView = backgroundView
        //cell.selectedBackgroundView?.backgroundColor = .green
        //cell.selectedBackgroundView?.tintColor = .green
        return cell;
    }
    
    // Define the number of rows in your tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is UINavigationController
        {
            //https://stackoverflow.com/questions/25369412/swift-pass-data-through-navigation-controller
            let vc = segue.destination as? UINavigationController
            //let cell = sender as! PodcastsTableViewCell
            if let chidVC = vc?.topViewController as? PodcastsDetailsViewController {
                chidVC.podcast = podcasts[0]
            }
        }
    }
}

// we cannot put the class below in a separate file due to a bug in XCode.
// It seems to me that my specific version of XCode 11.7 blocks
// the assistant from detecting the class if in a separate file
// but it works for the controller
// https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/CreateATableView.html
class PodcastsTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet var title: UILabel!
    @IBOutlet var partOfTheDescription: UILabel!
    @IBOutlet var numberOfEpisodes: UILabel!
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
