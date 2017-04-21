//
//  PageViewController.swift
//  SegmentedView
//
//  Created by Koushik S on 20/04/17.
//  Copyright © 2017 dhas-1579 y. All rights reserved.
//

import Foundation
import UIKit

protocol selectionDelegate:class{
    func dismissButtonClicked(index:Int)
}

class PageViewController:UIPageViewController{
    
    weak var selectionDelegate:selectionDelegate?
    private var _vcArray:[UIViewController] = []
    var selectedIndex:Int = 0
    
    var vcArray:[UIViewController]{
        get{
            return _vcArray
        }
        set(vcArray){
            
            for (i,viewController) in vcArray.enumerated()
            {
                viewController.view.tag = i
            }
            
            if let firstViewController = vcArray.first {
                setViewControllers([firstViewController],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            }
            _vcArray = vcArray
        }
    }

    override func viewDidLoad() {
        print("Viewcontroller array count \(vcArray.count)")
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    override func didReceiveMemoryWarning() {
               // Dispose of any resources that can be recreated.
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = vcArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = vcArray.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return vcArray.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return vcArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = vcArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return vcArray.last
        }
        
        guard vcArray.count > previousIndex else {
            return nil
        }
        return vcArray[previousIndex]
    }
    
}


extension PageViewController: UIPageViewControllerDelegate{
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        selectedIndex = pageViewController.viewControllers!.first!.view.tag
        //       self.pageControl.currentPage =
        selectionDelegate?.dismissButtonClicked(index: pageViewController.viewControllers!.first!.view.tag)
    }
    
    
    func buttonClickedat(index:Int){
        
        
        if(selectedIndex < index)
        {
        setViewControllers([vcArray[index]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        }else{
            setViewControllers([vcArray[index]],
                               direction: .reverse,
                               animated: true,
                               completion: nil)

        }
        selectedIndex = index
    }
}


