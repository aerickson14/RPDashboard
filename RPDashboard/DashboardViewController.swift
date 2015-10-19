//
//  DashboardViewController.swift
//  RPDashboard
//
//  Created by Andrew Erickson on 2015-10-18.
//  Copyright © 2015 Andrew Erickson. All rights reserved.
//

import UIKit

let DashboardRefreshInterval: NSTimeInterval = 60
let DashboardFadeOutInterval: NSTimeInterval = 3
let DashboardFadeInInterval: NSTimeInterval = 3

class DashboardViewController: UICollectionViewController {

    var refreshTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = self.collectionView?.collectionViewLayout as? RFQuiltLayout {
            layout.direction = .Horizontal
            layout.blockPixels = CGSizeMake(235, 235)
            layout.prelayoutEverything = true
        }
        
        self.collectionView?.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        startTimer()
    }
    
    func startTimer() {
        refreshTimer = NSTimer.scheduledTimerWithTimeInterval(DashboardRefreshInterval, target: self, selector: Selector("refreshBoard"), userInfo: nil, repeats: false)
        if let refreshTimer = refreshTimer {
            NSRunLoop.currentRunLoop().addTimer(refreshTimer, forMode: NSRunLoopCommonModes)
        }
    }
    
    func stopTimer() {
        refreshTimer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
    
    func refreshBoard() {
        stopTimer()
        
        UIView.animateWithDuration(DashboardFadeOutInterval, animations: { () -> Void in
            self.collectionView?.alpha = 0
            }) { (completed) -> Void in
                UIView.animateWithDuration(DashboardFadeInInterval, animations: { () -> Void in
                    self.collectionView?.alpha = 1
                    }) { (completed) -> Void in
                        self.startTimer()
                }
        }
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension DashboardViewController {
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier(indexPath), forIndexPath: indexPath)
        return cell
    }
    
    func reuseIdentifier(indexPath: NSIndexPath) -> String {
        
        switch(indexPath.row % 4) {
        case 0:
            return (indexPath.row % 8 == 0) ? "HistoryGraph":"TwoByOneCell"
        case 1:
            return (indexPath.row % 8 == 1) ? "HealthCell":"OneByOneCell"
        case 2:
            return "OneByTwoCell"
        case 3:
            return "TwoByTwoCell"
        default:
            return "OneByOneCell"
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    override func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let nextCell = context.nextFocusedView as? DashboardCollectionViewCell {
            nextCell.highlight()
        }
        
        if let prevCell = context.previouslyFocusedView as? DashboardCollectionViewCell {
            prevCell.unhighlight()
        }
    }
}

extension DashboardViewController: RFQuiltLayoutDelegate {
    
    func blockSizeForItemAtIndexPath(indexPath: NSIndexPath) -> CGSize {
        
        switch(indexPath.row % 4) {
        case 0:
            return CGSizeMake(2, 1)
        case 1:
            return CGSizeMake(1, 1)
        case 2:
            return CGSizeMake(1, 2)
        case 3:
            return CGSizeMake(2, 2)
        default:
            return CGSizeMake(1, 1)
        }
    }
}
