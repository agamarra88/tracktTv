//
//  PopularMoviesViewController.swift
//  TracktTv
//
//  Created by Arturo Gamarra on 9/8/16.
//  Copyright © 2016 Trivago. All rights reserved.
//

import UIKit
import SVPullToRefresh

private let kMinCellWidth:CGFloat = 210
private let kMinCellHeight:CGFloat = 280
private let kCellIdentifier = "PopularMovieCell"

class PopularMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UISearchControllerDelegate {

    // MARK: - Properties
    private var pageSize:Int = 10
    private var page:Int = 1
    private var columnsCount:Int {
        let columns = Int(self.collectionView.frame.width/kMinCellWidth)
        return columns >= 2 ? columns : 2
    }
    private var cellSize:CGSize {
        let width = self.collectionView.frame.width/CGFloat(self.columnsCount)
        return CGSizeMake(width-4, kMinCellHeight)
    }
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    var searchController:UISearchController?
    var searchBarContainerView:UIView?
    var movies:[Movie] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchViewController()
        self.collectionView.addInfiniteScrollingWithActionHandler { [unowned self] () -> Void in
            self.page += 1;
            self.loadMoviesAtPage(self.page)
        }
        self.collectionView.addPullToRefreshWithActionHandler { [unowned self] () -> Void in
            self.page = 1
            self.loadMoviesAtPage(self.page)
        }
        self.loadMoviesAtPage(self.page)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (self.searchController!.active) {
            self.searchBarContainerView?.hidden = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (self.searchBarContainerView == nil) {
            self.addSearchBarToContainer()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBarContainerView?.hidden = true
    }
    
    // MARK: - Private
    private func setupSearchViewController() {
        let searchVC = MovieSearchViewController.instanceFromStoryboard()
        self.searchController = UISearchController(searchResultsController: searchVC)
        self.searchController?.delegate = self
        self.searchController?.searchResultsUpdater = self
        self.searchController?.dimsBackgroundDuringPresentation = true
        self.searchController?.hidesNavigationBarDuringPresentation = false
        self.searchController?.searchBar.showsCancelButton = true
        self.searchController?.searchBar.backgroundImage = UIImage.fromColor(UIColor.clearColor())
        self.definesPresentationContext = true
    }
    
    private func loadMoviesAtPage(page:Int) {
        self.showActivityIndicator()
        MovieService.sharedService.loadPopularMoviesAtPage(page, ofSize: self.pageSize
            , withSuccess: { (movies) in
                self.hideActivityIndicator()
                if (page == 1) {
                    self.movies.removeAll()
                }
                self.movies.appendContentsOf(movies)
                self.collectionView.pullToRefreshView.stopAnimating()
                self.collectionView.infiniteScrollingView.stopAnimating()
                self.collectionView.reloadData()
            }
            , withFailure: { (error) in
                self.page -= page != 1 ? 1 : 0
                self.hideActivityIndicator()
                self.collectionView.pullToRefreshView.stopAnimating()
                self.collectionView.infiniteScrollingView.stopAnimating()
                self.showErrorViewWithMessage(error.localizedDescription)
        })
    }
    
    private func setSearchButtonVisilble(visible:Bool) {
        let tintColor = visible ? UIColor.whiteColor() : UIColor.clearColor()
        self.searchButton.enabled = visible;
        self.searchButton.tintColor = tintColor;
    }
    
    private func addSearchBarToContainer() {
        self.searchBarContainerView = UIView(frame: self.navigationController!.navigationBar.bounds)
        self.searchBarContainerView?.frame.size.width -= 8
        self.searchBarContainerView?.frame.origin.x += 8
        self.searchBarContainerView?.addSubview(self.searchController!.searchBar)
        self.navigationController?.navigationBar.addSubview(self.searchBarContainerView!)
        self.searchBarContainerView?.hidden = true
    }
    
    // MARK: - Action
    @IBAction func searchButtonTouched(sender: UIBarButtonItem) {
        self.setSearchButtonVisilble(false)
        self.searchBarContainerView?.hidden = false
        self.searchController?.searchBar.becomeFirstResponder()
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! MovieCell
        let movie = self.movies[indexPath.item]
        cell.setupCellWithMovie(movie)
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.cellSize
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchVC = self.searchController?.searchResultsController as? MovieSearchViewController else {
            return
        }
        
        if (searchController.active) {
            let text = searchController.searchBar.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            searchVC.searchMoviesWithText(text!)

        } else {
            self.searchBarContainerView?.hidden = true
            self.setSearchButtonVisilble(true)
            searchVC.clearResults()
        }
    }

}
