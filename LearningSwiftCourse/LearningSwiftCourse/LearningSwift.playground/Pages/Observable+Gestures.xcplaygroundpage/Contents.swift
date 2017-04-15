//: [Previous](@previous)

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
containerView.backgroundColor = UIColor.red

var disposeBag = DisposeBag()

let frame = CGRect(x: 50, y: 100, width: 200, height: 200)
let button = UIButton(frame: frame)
button.backgroundColor = UIColor.blue
button.setTitle("Press me!", for: UIControlState.normal)
button.setTitleColor(UIColor.white, for: UIControlState.normal)
button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
containerView.addSubview(button)

//button
//.rx
//.tap
//.subscribe(onNext: { tap in
//    print("Tap")
//}).addDisposableTo(disposeBag)

//https://github.com/RxSwiftCommunity/RxGesture
//containerView
//.rx
//.tapGesture()
//.when(.recognized)
//.subscribe(onNext: { tap in
//    print("tapping \(tap)")
//})
//.addDisposableTo(disposeBag)

//containerView.rx
//.anyGesture(.tap(), .swipe([.up, .down]))
//.when(.recognized)
//.subscribe(onNext: { gesture in
//    print("swipesss")
//    // Called whenever a tap, a swipe-up or a swipe-down is recognized (state == .recognized)
//})
//.addDisposableTo(disposeBag)

/*
containerView.rx
.anyGesture(
    (.tap(), when: .recognized),
    (.pan(), when: .ended)
)
.subscribe(onNext: { gesture in
    // Called whenever:
    // - a tap is recognized (state == .recognized) 
    // - or a pan is ended (state == .ended)
    print("tap and pan ended")
})
.addDisposableTo(disposeBag)
*/
 
/*
let tapPressGesture = UILongPressGestureRecognizer()
tapPressGesture.minimumPressDuration = 0.0
tapPressGesture
    .rx
    .event
    .subscribe( onNext: { tap in
        
        let location = tap.location(in:containerView)
        
        switch tap.state {
        case .began: 
            if (button.frame.contains(location)){
                print("Tapped Button")
            }
            break;
        case .changed:
            print("location x:\(location.x) , y:\(location.y) ")
            button.center = location
            break;
        case .ended:
            print("tap ended")
            break;
        default:
            print("tap ")
        }   
    }).addDisposableTo(disposeBag)
containerView.addGestureRecognizer(tapPressGesture)   
*/

var animator:UIDynamicAnimator? = nil
var snapBehavior: UISnapBehavior!
let panGesture = UIPanGestureRecognizer()

animator = UIDynamicAnimator(referenceView:containerView);

panGesture
    .rx
    .event
    .subscribe( onNext: { pan in  
    
    let location = pan.location(in: containerView);
    
    animator?.removeAllBehaviors()
    
    switch pan.state {
    case .began: 
        if (button.frame.contains(location)){
            button.center = pan.location(ofTouch: 0, in: containerView);
        }
        //print("Began", point)
    case .changed: 
        if (button.frame.contains(location)){
            button.center = pan.location(ofTouch:0, in: containerView)
        }
        //print("Changed", point)
    case .ended: 
        
        if (snapBehavior != nil) {
            animator?.removeBehavior(snapBehavior)
        }
        
        snapBehavior = UISnapBehavior(item: button, snapTo: CGPoint(x: containerView.frame.width / 2, y: containerView.frame.height / 2))
        animator?.addBehavior(snapBehavior)
        
        //print("Ended", point) 
    default:
        print(panGesture)
    }

}).addDisposableTo(disposeBag)

containerView.addGestureRecognizer(panGesture)

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true
