//: [Previous](@previous)

import Foundation
import UIKit
import RxSwift
import PlaygroundSupport
import LearningSwiftCourseExtensions


let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
containerView.backgroundColor = UIColor.blue

let label = UILabel(frame:CGRect(x: 0, y: 0, width: 200, height: 30))
label.textAlignment = .center
label.font = label.font.withSize(12)
label.center = CGPoint(x:80, y: containerView.center.y)
containerView.addSubview(label)


let colors = UIColor.getAllColorNamesFromLibrary()

var disposeBag = DisposeBag()
//Observable Interval
let observableInterval = Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
observableInterval
    .take(colors.count)
    .subscribe(onNext: { (index) in
        label.text = colors[index] 
        containerView.backgroundColor = UIColor(hex: colors[index] )
    }).addDisposableTo(disposeBag)

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true
