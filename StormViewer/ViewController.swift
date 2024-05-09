//
//  ViewController.swift
//  StormViewer
//
//  Created by Rodrigo Cavalcanti on 06/03/24.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    var selectedItem: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        performSelector(inBackground: #selector(populatePictures), with: nil)
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
    
    @objc func populatePictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! // iOS projects always have a resource path.
        let items = try! fm.contentsOfDirectory(atPath: path) // Impossible to run any project without loading the resource content.
        
        var bundlePictures = [String]()
        
        for item in items {
            if item.hasPrefix("nssl") {
                // This is a picture to load!
                bundlePictures.append(item)
            }
        }
        
        bundlePictures.sort()
        
        DispatchQueue.main.async { [weak self] in
            self?.pictures = bundlePictures
            self?.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? NSSLCell else { fatalError() }
        let fileName = pictures[indexPath.item]
        cell.image.image = UIImage(named: fileName)
        cell.name.text = fileName
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 4
        
        let defaults = UserDefaults.standard
        cell.viewCount.text = String(defaults.integer(forKey: fileName))
        cell.stackView.layer.cornerRadius = 6
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            let pictureIndex = indexPath.item + 1
            vc.index = pictureIndex
            vc.total = pictures.count
            self.selectedItem = indexPath
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recommendTapped() {
        let message = "Experience the awe-inspiring force of nature with StormViewer. Browse, select, and share stunning images from the National Severe Storms Laboratory effortlessly."
        
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // Which item made the ShareSheet appear on iPad
        present(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let selectedItem {
            collectionView.reloadItems(at: [selectedItem])
        }
    }
}

#Preview {
    UIStoryboard(
        name: "Main",
        bundle: nil
    )
    .instantiateInitialViewController()!
}
