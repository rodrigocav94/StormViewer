//
//  ViewController.swift
//  StormViewer
//
//  Created by Rodrigo Cavalcanti on 06/03/24.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        populatePictures()
    }

    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm  Viewer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(recommendTapped)
        )
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
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            let pictureIndex = indexPath.row + 1
            vc.index = pictureIndex
            vc.total = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recommendTapped() {
        let message = "Experience the awe-inspiring force of nature with StormViewer. Browse, select, and share stunning images from the National Severe Storms Laboratory effortlessly."

        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // Which item made the sharesheet appear on iPad
        present(vc, animated: true)
    }
}

#Preview {
    UIStoryboard(
        name: "Main",
        bundle: nil
    )
    .instantiateInitialViewController()!
}
