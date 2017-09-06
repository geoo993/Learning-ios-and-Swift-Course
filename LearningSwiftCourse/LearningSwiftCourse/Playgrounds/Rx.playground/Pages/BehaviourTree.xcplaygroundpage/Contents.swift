//: [Previous](@previous)

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol Command {}
protocol State {}
protocol Event {}
protocol Action {
    func act() 
}
protocol Task {}

protocol BehaviourTree {
   func start() -> Observable<State> 
}

class TouchPointer : UIView, BehaviourTree {
    struct Hide : Command {}
    struct Hiding : Action {}
    struct Hidden : State {}
    
    struct Show : Command {}
    struct Showing : Action {}
    struct Shown : State {} 
    
    struct Idle : State {}
    struct MoveTo : Command {}
    
    struct Dragging : State {}
    struct Throwing : State {}
        
    func start() -> Observable<State> {
        return Observable.just(Hidden())
    }
    
    func handle(command: Command) {
        switch command {
        case _ as Hide:
            print("handle Hide")
            break
        default: break
        }
    }
}

extension TouchPointer.Hiding {
    func act() {
        print("Hiding")
    }
}

extension TouchPointer.Showing  {
    func act() {
        print("Showing")
    }
}

struct UI {
    let textbox = UITextField(frame: CGRect(x: 30, y: 100, width: 300, height: 30))
    let label = UILabel(frame: CGRect(x: 200, y: 30, width: 150, height: 30) )
    let button = UIButton(frame: CGRect(x: 30, y: 30, width: 150, height: 30))
    let touchPointer = TouchPointer(frame: CGRect(x: 30, y: 200, width: 100, height: 100))
    lazy var allViews : [UIView] = {[self.textbox, self.label, self.button, self.touchPointer]}()
    var disposeBag = DisposeBag()
    init() {
        textbox.backgroundColor = UIColor.whiteColor()
        touchPointer.backgroundColor = UIColor.redColor()
        label.text = "No result"
        label.textColor = UIColor.whiteColor()
        button.setTitle("Press me:", forState: UIControlState.Normal)
        self.touchPointer.handle(TouchPointer.Hide())
        //button.rx_tap
        //.subscribeNext { self.touchPointer.handle(hide) }
        //.addDisposableTo(disposeBag)
    }
}

let vc = UIViewController()
var ui = UI()
ui.allViews.forEach { vc.view.addSubview($0) }
import XCPlayground
XCPlaygroundPage.currentPage.liveView = vc



print("Finished 😀")
//: [Next](@next)
