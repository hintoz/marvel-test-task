//
//  ItemTableViewCell.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ItemTableViewCell"

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(item: Results) {
        if let thumb = item.thumbnail?.path, let ext = item.thumbnail?.extens {
            thumbImageView.af_setImage(withURL: URL(string: "\(thumb).\(ext)")!,
                                       placeholderImage: UIImage(named: "person-placeholder.png"),
                                       imageTransition: .crossDissolve(0.2),
                                       runImageTransitionIfCached: false)
        }
        
        nameLabel.text = item.name
    }
    
}
