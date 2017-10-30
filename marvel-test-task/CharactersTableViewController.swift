//
//  CharactersTableViewController.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import UIKit

fileprivate let model = try! AppDelegate.assembly.resolve() as CharactersModel
class CharactersTableViewController: UITableViewController {

    let behavior = TableViewPaginableBehavior()
    let control = UIRefreshControl()
    var refreshing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = behavior
        tableView.dataSource = self
        behavior.delegate = self
        
//        tableView.estimatedRowHeight = 76
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellGesture(_:))))
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UINib(nibName: String(describing: LoadingTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: String(describing: ItemTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
        
        title = "Marvel characters"
        
        // Pull to refresh
        control.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        if #available(iOS 10.0, *) {
            tableView?.refreshControl = control
        } else {
            tableView?.addSubview(control)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refresh() {
        refreshing = true
        model.refresh()
        refreshing = false
        behavior.reloadData()
        behavior.fetchNextData(forSection: 0) {
            self.tableView?.reloadData()
        }
        control.endRefreshing()
    }
    
    @objc func cellGesture(_ sender: UITapGestureRecognizer) {
        if let indexPath = self.tableView?.indexPathForRow(at: sender.location(in: self.tableView)) {
            showDetailVC(with: model.items[indexPath.row])
        }
    }
    
    func showDetailVC(with item: Results) {
        if let detailVC = DetailViewController.storyboardInstance() {
            detailVC.item = item
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}

// MARK: - Table view data source
extension CharactersTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (model.items.count) + (self.behavior.sectionStatus(forSection: section).done ? 0 : 1)
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < model.items.count else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier, for: indexPath) as! LoadingTableViewCell
            if !self.refreshing {
                cell.set(moreToLoad: !self.behavior.sectionStatus(forSection: indexPath.section).done)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier, for: indexPath) as! ItemTableViewCell
        cell.set(item: model.items[indexPath.row])
        return cell
     }
    
}

extension CharactersTableViewController: TableViewPaginableBehaviorDelegate {
    func paginableBehavior(_ paginableBehavior: TableViewPaginableBehavior, countPerPageInSection section: Int) -> Int {
        return Config.marvel.limit
    }
    
    func paginableBehavior(_ paginableBehavior: TableViewPaginableBehavior, fetchDataFrom indexPath: IndexPath, count: Int, completion: @escaping (Error?, Int) -> Void) {
        model.loadCharacters { (count) in
            completion(nil, count ?? 0)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = DetailViewController.storyboardInstance() {
            detailVC.item = model.items[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
