//
//  DetailViewController.swift
//  Milestone2_Challenge
//
//  Created by Guillermo Lella on 8/26/20.
//  Copyright © 2020 Guillermo Lella. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedFlag: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Not wasting time with this as the border of layer takes whole screen and would need to create a
        // new image with border as mentioned in:
        // https://stackoverflow.com/questions/1354811/how-can-i-take-an-uiimage-and-give-it-a-black-border
        //imageView.layer.borderWidth = 1
        //imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        if let imageToLoad = selectedFlag {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1.0) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
