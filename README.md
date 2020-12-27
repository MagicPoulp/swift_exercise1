# Nice features

We do not use the recent library SwiftUI because not all devices can run it.

We use a Table View because it suits well the problem at hand. We also use a  Material Design List based on a UICollectionViewController and using a Podfile.

We use the Interface Builder and Auto Layout as much as possible.

We use a global tab navigation controller. And in the podcasts page, we have a container that embedds a table view controller.

We use a popup for the details page because it can take the whole screen. And we have a custom back button to dismiss the popup.

We customized thoroughly the table view, with extra colors, and using StackView.

# Licenses

See the licenses folder for all the various licenses used.

# Author

Thierry Vilmart
2020
https://github.com/MagicPoulp/audio_analyzer
https://github.com/MagicPoulp/display_vulkan_from_kotlin_or_swift

# How to run

See the back_end folder and the readme to start the server

You may need to install cocoapods with brew, and then run "pod install" in the shell where the file Podfile is located

# Documentation

## The assignment

See the doc folder for the assignment.

## Google Material Design for iOS

https://material.io/components/lists/ios#using-lists
how to customize a collection layout
https://www.raywenderlich.com/4829472-uicollectionview-custom-layout-tutorial-pinterest

## View controllers

embed view controllers in a tree:
https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html
https://stackoverflow.com/questions/17499391/ios-nested-view-controllers-view-inside-uiviewcontrollers-view

Here it is said that a Table View Controller is necessary:
https://developer.apple.com/documentation/uikit/views_and_controls/table_views
"Table view controller. You typically use a UITableViewController object to manage a table view. You can use other view controllers too, but a table view controller is required for some table-related features to work."

pass data
https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/#forward-segues

## UITableView

official doc for a table view:
https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/CreateATableView.html

how to navigate inside a table:
https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/ImplementNavigation.html#//apple_ref/doc/uid/TP40015214-CH16-SW1

stack view cell
https://ripplearc.github.io/iOS-UI-AutoSize-UITableViewCell/

tutorial to use UITableView that is superior to UIScrollView for repeated patterns.
but too many library customization files on libraries
http://swiftyjimmy.com/rxswift-with-mvvm-part1/
https://github.com/JussiSuojanen/friends/tree/RxSwift/Friends

## UIScrollView

tutorials for the scrollable view
deprecated tutorial
https://medium.com/@jessesahli3/laying-out-dynamic-uiscrollviews-in-interface-builder-e4f0645bc2c7

For scrollable views, better tutorial that gives the solution with layout guides in XCode 11
https://medium.com/@barteknowacki/uiscrollview-explained-uiscrollview-with-auto-layout-and-content-layout-guides-tutorial-77cf158a47e3

