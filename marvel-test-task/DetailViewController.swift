//
//  DetailViewController.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    var item: Results?

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            if let thumb = item.thumbnail?.path, let ext = item.thumbnail?.extens {
                thumbImageView.af_setImage(withURL: URL(string: "\(thumb).\(ext)")!,
                                           placeholderImage: UIImage(named: "person-placeholder.png"),
                                           imageTransition: .crossDissolve(0.2),
                                           runImageTransitionIfCached: false)
            }
            title = item.name
            descriptionLabel.text = item.descriptionValue != "" ? item.descriptionValue : "Описание отсутствует"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    static func storyboardInstance() -> DetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? DetailViewController
    }

}
