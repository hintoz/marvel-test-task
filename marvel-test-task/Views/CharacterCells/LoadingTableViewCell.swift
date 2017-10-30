//
//  LoadingTableViewCell.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "LoadingTableViewCell"

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(moreToLoad: Bool) {
        if moreToLoad {
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}
