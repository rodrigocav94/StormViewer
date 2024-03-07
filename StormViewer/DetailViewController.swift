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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//#Preview {
//    UIStoryboard(
//        name: "Detail",
//        bundle: nil
//    )
//    .instantiateInitialViewController()!
//}
