//
//  MovieSearchViewController.swift
//  TracktTv
//
//  Created by Arturo Gamarra on 9/9/16.
//  Copyright © 2016 Trivago. All rights reserved.
//

import UIKit

private let kMovieSearchViewControllerIdentifier = "MovieSearchViewController"
private let kCellIdentifier = "MovieSearchCell"

class MovieSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MRK: - Properties
    private var keyBoardHeight:CGFloat = 0.0
    private var pageSize:Int = 10
    private var page:Int = 1
    private var text:String = ""
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    var movies:[Movie] = []
    
    // MRK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.willShowKeyboardNotitification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.willHideKeyboardNotitification(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.addInfiniteScrollingWithActionHandler { [unowned self] () -> Void in
            self.page += 1;
            self.searchMoviesWithText(self.text ,atPage: self.page)
        }
        self.tableView.addPullToRefreshWithActionHandler { [unowned self] () -> Void in
            self.page = 1
            self.searchMoviesWithText(self.text ,atPage: self.page)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewBottomConstraint.constant = self.keyBoardHeight
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.willShowKeyboardNotitification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.willHideKeyboardNotitification(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private
    private func searchMoviesWithText(text:String, atPage page:Int) {
        self.showActivityIndicator()
        MovieService.sharedService.searchMoviesWithText(text, atPage: page, ofSize: self.pageSize
            , withSuccess: { (movies) in
                self.hideActivityIndicator()
                if (page == 1) {
                    self.movies.removeAll()
                }
                self.movies.appendContentsOf(movies)
                self.tableView.pullToRefreshView.stopAnimating()
                self.tableView.infiniteScrollingView.stopAnimating()
                self.tableView.reloadData()
            }
            , withFailure: { (error) in
                self.page -= page != 1 ? 1 : 0
                self.hideActivityIndicator()
                self.tableView.pullToRefreshView.stopAnimating()
                self.tableView.infiniteScrollingView.stopAnimating()
                //self.showErrorViewWithMessage(error.localizedDescription)
        })
    }


    // MARK: - Public
    class func instanceFromStoryboard() -> MovieSearchViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard.instantiateViewControllerWithIdentifier(kMovieSearchViewControllerIdentifier) as? MovieSearchViewController
    }
    
    func searchMoviesWithText(text:String) {
        self.page = 1
        self.text = text
        self.movies.removeAll()
        self.tableView.reloadData()
        if (self.text != "") {
            self.searchMoviesWithText(self.text ,atPage: self.page)
        }
    }
    
    func clearResults() {
        self.page = 1
        self.movies.removeAll()
        self.tableView.reloadData()
    }
    
    // MARK: - Notification
    func willShowKeyboardNotitification(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            self.keyBoardHeight = keyboardSize.height
            if (self.tableViewBottomConstraint != nil) {
                self.tableViewBottomConstraint.constant = self.keyBoardHeight
            }
        }
    }
    
    func willHideKeyboardNotitification(notification:NSNotification) {
        if (self.tableViewBottomConstraint != nil) {
            self.tableViewBottomConstraint.constant = 0
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! SearchMovieCell
        let movie = self.movies[indexPath.item]
        cell.setupCellWihMovie(movie)
        return cell
    }

}
