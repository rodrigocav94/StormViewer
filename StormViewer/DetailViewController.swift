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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    func loadImage() {
        if let selectedImage {
            imageView.image = UIImage(named: selectedImage)
        }
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
