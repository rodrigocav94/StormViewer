//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Rodrigo Cavalcanti on 06/03/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var index: Int?
    var total: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        loadImage()
    }
    
    func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        if let index, let total {
            self.title = "Picture \(index) of \(total)"
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped)
        )
    }
    
    func loadImage() {
        if let selectedImage {
            imageView.image = UIImage(named: selectedImage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let activityItems =  [image, selectedImage as Any]

        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // Which item made the sharesheet appear on iPad
        present(vc, animated: true)
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
    vc.selectedImage = "nssl0033.jpg"
    vc.index = 1
    vc.total = 10
    let navController = UINavigationController(rootViewController: vc)
    return navController
}
