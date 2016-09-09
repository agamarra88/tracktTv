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

class PopularMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

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
    var movies:[Movie] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Private
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


}
