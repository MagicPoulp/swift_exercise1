//
//  HttpManager.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-27.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

// we could use a library (like Refit, or RetrofireSwift), but it is also a security concern to trust the library
// and I do not have time to check the libraries
// we also need a better way to react to errors and display errors
// maybe this could be moved to a delegate
// https://cocoacasts.com/fm-3-download-an-image-from-a-url-in-swift

class HttpManager {
    
    func get(url: String, callback: @escaping (Data) -> Void) {
        // Create URL
        // here is how to make it work on HTTPS with more work:
        // https://jaanus.com/ios-13-certificates/
        let urlObject = URL(string: url)!

        // a new thread prevent blocking the main thread
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: urlObject) {
                // as said in the tutorial UI updates must be run on the main thread
                DispatchQueue.main.async {
                    // decoding taken from here:
                    // https://programmingwithswift.com/parse-json-from-file-and-url-with-swift/
                    // use URLSession like in the link above to catch preoperly http errors
                    //let dataJson = data.data(using: .utf8)!
                    callback(data)
                }
            }
        }
    }
}
