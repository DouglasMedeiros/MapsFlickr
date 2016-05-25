//
//  PhotoDetailViewController.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoTitle: UILabel!
    @IBOutlet weak var photoImage: UIImageView!

    private var photoAnnotation: PhotoAnnotation!

    init(photoAnnotation: PhotoAnnotation) {
        super.init(nibName: "PhotoDetail", bundle: nil)

        self.photoAnnotation = photoAnnotation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.photoTitle.text = photoAnnotation.title
        self.photoImage.image = photoAnnotation.cachedBigImage
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
