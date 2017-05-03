//
//  ViewController.swift
//  SegmentedView
//
//  Created by dhas-1579 y. on 20/04/17.
//  Copyright © 2017 dhas-1579 y. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController {

    var titleArray = ["Alarm","Conversation","Event","Alarm","Conversation","Event","Alarm"]
//    var titleArray = ["Alarm","Conversation","Event","Alarm"]
    var stackView = UIStackView.init()
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var upperScroll: UIScrollView!
    @IBOutlet weak var tempView: UILabel!
    @IBOutlet weak var tempView2: UIView!
    @IBOutlet weak var tempView1: UILabel!
    @IBOutlet weak var pageContainerView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var highLightView = UIView.init()
    var upperScrollPadding = 0
    var segmentHeaderFont:UIFont = UIFont.systemFont(ofSize: 16)
    var upperScrollHeight = 60
    var pageVC:PageViewController = PageViewController()
    var viewControllerArray:[UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initThings()
        
        upperScroll.backgroundColor = UIColor.clear
        upperScroll.showsHorizontalScrollIndicator = false
        upperScroll.showsVerticalScrollIndicator = false
        upperScroll.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10.0
        stackView.backgroundColor = UIColor.red
        tempView2.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: tempView2.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: tempView2.trailingAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: tempView2.centerYAnchor, constant: 0).isActive = true
    
        for (i,titleText) in titleArray.enumerated(){
            let button = UIButton.init()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = i
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.setTitle(titleText, for: .normal)
            button.setTitle(titleText, for: .application)
            button.setTitle(titleText, for: .highlighted)
            button.addTarget(self, action:#selector(handleRegister(sender:)), for: .touchUpInside)
            button.backgroundColor = UIColor.clear
            stackView.addArrangedSubview(button)
        }
        
        var widthFloat:Int = 0
        let fontAttributes = [NSFontAttributeName: segmentHeaderFont] // it says name, but a UIFont works
        let myText = titleArray[0]
        let size = (myText as NSString).size(attributes: fontAttributes)
        widthFloat = Int(size.width)
        
        highLightView.backgroundColor = UIColor.darkGray
        let frame:CGRect = stackView.arrangedSubviews[0].frame
        self.highLightView.frame = CGRect(x: Int(frame.origin.x+5) , y:upperScrollHeight-5  , width: widthFloat , height: 5)
        stackView.addSubview(highLightView)
        
        pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal , options: nil)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.vcArray = viewControllerArray
        pageVC.selectionDelegate = self
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        
        pageVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pageVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pageVC.view.topAnchor.constraint(equalTo: upperScroll.bottomAnchor).isActive = true
        pageVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    func initThings(){
        heightConstraint.constant = 80
        let view:UIViewController = UIViewController()
        view.view.backgroundColor = UIColor.red
        viewControllerArray.append(view)
        let view1:UIViewController = UIViewController()
        view1.view.backgroundColor = UIColor.green
        viewControllerArray.append(view1)
        let view2:UIViewController = UIViewController()
        view2.view.backgroundColor = UIColor.blue
        viewControllerArray.append(view2)
        let view3:UIViewController = UIViewController()
        view3.view.backgroundColor = UIColor.yellow
        viewControllerArray.append(view3)
        let view6:UIViewController = UIViewController()
        view6.view.backgroundColor = UIColor.orange
        viewControllerArray.append(view6)
        let view4:UIViewController = UIViewController()
        view4.view.backgroundColor = UIColor.purple
        viewControllerArray.append(view4)
        let view5:UIViewController = UIViewController()
        view5.view.backgroundColor = UIColor.magenta
        viewControllerArray.append(view5)
    }
    
    func handleRegister(sender: UIButton) {
        
        let frame:CGRect = sender.frame
        pageVC.buttonClickedat(index: sender.tag)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.highLightView.frame = CGRect(x: frame.origin.x , y:CGFloat(self.upperScrollHeight-5) , width: frame.size.width , height: 5)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SegmentedViewController:selectionDelegate{
    func dismissButtonClicked(index: Int) {
        
        let frame:CGRect = stackView.arrangedSubviews[index].frame
         UIView.animate(withDuration: 0.2, animations: {
        
        if((frame.origin.x + frame.size.width) > self.view.bounds.size.width)
        {
            self.upperScroll.contentOffset = CGPoint(x: (frame.origin.x+frame.size.width+20)-(self.view.bounds.size.width-100), y: self.upperScroll.contentOffset.y)
        }
        else if(self.upperScroll.contentOffset.x > frame.origin.x ){
             self.upperScroll.contentOffset = CGPoint(x: frame.origin.x , y: self.upperScroll.contentOffset.y)
        }
       
            self.highLightView.frame = CGRect(x: frame.origin.x , y:CGFloat(self.upperScrollHeight-5) , width: frame.size.width , height: 5)
        })
    }
}

