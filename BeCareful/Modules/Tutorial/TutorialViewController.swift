//
//  TutorialViewController.swift
//  BeCareful
//
//  Created by Mariana Parente on 22/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var exitTutorial: UIButton!

    var images: [String] = ["1", "2", "3"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = images.count
    }

    override func viewDidLayoutSubviews() {
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size

            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imageView)
        }

        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(images.count)), height: scrollView.frame.size.height)
    }

    @IBAction func exitTutorial(_ sender: UIButton) {
        AppUserDefaults.isTutorialShown = true
        AppDelegate.sharedInstance.loadRegister()
    }
}

extension TutorialViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        if Int(pageNumber) == images.count-1 {
            exitTutorial.setTitle("Salir", for: .normal)
        } else {
            exitTutorial.setTitle("Omitir", for: .normal)
        }
    }
}
