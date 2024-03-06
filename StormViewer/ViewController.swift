//
//  ViewController.swift
//  StormViewer
//
//  Created by Rodrigo Cavalcanti on 06/03/24.
//

import UIKit

class ViewController: UIViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        populatePictures()
    }

    func populatePictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! // iOS projects always habe a resource path.
        let items = try! fm.contentsOfDirectory(atPath: path) // Impossible to run any project without loading the resource content.
        
        for item in items {
            if item.hasPrefix("nssl") {
                // This is a picture to load!
                pictures.append(item)
            }
        }
    }
}

#Preview {
  let button = ViewController()
  return button
}
