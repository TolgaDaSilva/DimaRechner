//
//  DetailsViewController.swift
//  DimaRechner
//
//  Created by Tolga Akkiraz on 09.11.17.
//  Copyright © 2017 Tolga Akkiraz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UIScrollViewDelegate{

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ImgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ScrollView.maximumZoomScale = 6.0
        self.ScrollView.minimumZoomScale = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZooming(in ScrollView: UIScrollView) -> UIView? {
        return self.ImgView
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
