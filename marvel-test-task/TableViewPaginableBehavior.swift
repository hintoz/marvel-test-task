//
//

import UIKit

@objc
public protocol TableViewPaginableBehaviorDelegate: UITableViewDelegate {
	/**
	* Gives the number of items to fetch for a given section.
	*/
	@objc optional func paginableBehavior(_ paginableBehavior: TableViewPaginableBehavior, countPerPageInSection section: Int) -> Int
	/**
	* Core methods that will be called every time the user reach the end of the collection, 
	* depending on the value set for the automatic fetch option.
	*/
	@objc optional func paginableBehavior(_ paginableBehavior: TableViewPaginableBehavior, fetchDataFrom indexPath: IndexPath, count: Int, completion: @escaping (Error?, Int) -> Void)
}

open class TableViewPaginableBehavior: NSObject {

	/**
	*	Struct used to configure the behavior of the component.
	*	`automaticFetch`	tells if the component will call the delegate automatically
							to fetch the next chunk of data at the end of a section,
	*
	*	`countPerPage`		default value used for all section, avoiding to implement the delegate,
	*	`animatedUpdate`	defines if the method reloadSection will be used after fetching the data.
	*/
    public struct Options: CustomStringConvertible {
        public var automaticFetch: Bool
        public var countPerPage: Int
		public var animatedUpdates: Bool

		public init(automaticFetch: Bool = true, countPerPage: Int = 10, animatedUpdates: Bool = false) {
            self.automaticFetch = automaticFetch
            self.countPerPage = countPerPage
			self.animatedUpdates = animatedUpdates
        }

        public var description: String {
            return "[TableViewPaginableBehavior.Options automaticFetch:\(self.automaticFetch), countPerPage:\(self.countPerPage)]"
        }
    }

	/**
	*	Struct mantaining information of each section.
	*	`fetching`	tells if the section is currently fetching data,
	*	`done`		tells if the section has fetched all data and no more data to load,
	*	`error`		tells if during the last fetch attempt an error occured,
	*	`index`		the next index to fetch data from.
	*/
    public struct SectionStatus: CustomStringConvertible {
        public var fetching: Bool
        public var done: Bool
        public var error: Error?
		public var index: Int

		init(index: Int = 0, fetching: Bool = false, done: Bool = false, error: Error? = nil) {
            self.fetching = fetching
            self.done = done
            self.error = error
			self.index = index
        }

        public var description: String {
            return "[TableViewPaginableBehavior.SectionStatus fetching:\(self.fetching), done:\(self.done), error:\(String(describing: self.error))]"
        }
    }

	open var options: Options
	fileprivate var sectionStatuses: [Int: SectionStatus]
	fileprivate weak var tableView: UITableView?

	public weak var delegate: TableViewPaginableBehaviorDelegate?

	public override init() {
		self.sectionStatuses = [Int: SectionStatus]()
		self.options = Options()
        super.init()
	}

	open override func responds(to aSelector: Selector!) -> Bool {
        if let delegate = self.delegate,
            delegate.responds(to: aSelector) {
            return true
        }
        return super.responds(to: aSelector)
	}

	open override func forwardingTarget(for aSelector: Selector!) -> Any? {
		if let delegate = self.delegate,
			delegate.responds(to: aSelector) {
			return delegate
		}
		return nil
	}

	public func sectionStatus(forSection section: Int) -> SectionStatus {
		return self.sectionStatuses[section] ?? SectionStatus()
	}

    public func fetchNextData(forSection section: Int, completionHandler: @escaping () -> ()) {
		var sectionStatus = self.sectionStatuses[section] ?? SectionStatus()

		if self.sectionStatuses[section] == nil {
			guard let tableView = self.tableView else {
				return
			}

			let index = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
			sectionStatus = SectionStatus(index: index)
		}

		let count = self.delegate?.paginableBehavior?(self, countPerPageInSection: section) ?? self.options.countPerPage

        guard !sectionStatus.fetching && !sectionStatus.done else {
            self.sectionStatuses[section] = sectionStatus
            return
        }

        sectionStatus.fetching = true
        self.sectionStatuses[section] = sectionStatus
        let fromIndexPath = IndexPath(item: sectionStatus.index, section: section)
        self.delegate?.paginableBehavior?(self, fetchDataFrom: fromIndexPath, count: count, completion: { (error, dataCount) in
            if error == nil {
                sectionStatus.done = (dataCount == 0 || dataCount < count)
                sectionStatus.index += count
            }
            sectionStatus.error = error
            sectionStatus.fetching = false
            self.sectionStatuses[section] = sectionStatus
            completionHandler()
        })
	}

	public func reloadData() {
		self.sectionStatuses = [Int: SectionStatus]()
		self.tableView?.reloadData()
	}
}

extension TableViewPaginableBehavior: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView = tableView
        self.delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
        
        guard let dataSource = tableView.dataSource, indexPath.row >= (dataSource.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1) else {
            return
        }
        
        let sectionStatus = self.sectionStatus(forSection: indexPath.section)
        
        if self.options.automaticFetch && sectionStatus.error == nil {
            self.fetchNextData(forSection: indexPath.section) {
                if self.options.animatedUpdates {
                    tableView.reloadSections([indexPath.section], with: UITableViewRowAnimation.none)
                } else {
                    UIView.performWithoutAnimation {
                        tableView.reloadSections([indexPath.section], with: UITableViewRowAnimation.none)
                    }
                }
            }
        }
    }
}
