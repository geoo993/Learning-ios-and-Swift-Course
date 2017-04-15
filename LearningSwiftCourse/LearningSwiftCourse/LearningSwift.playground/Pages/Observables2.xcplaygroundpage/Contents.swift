//: [Previous](@previous)

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxGesture
import PlaygroundSupport

////use rx marbels http://rxmarbles.com/
//http://candycode.io/a-practical-mvvm-example-in-swift-part-1/
//http://swiftpearls.com/RxSwift-for-dummies-1-Observables.html
//MVVM (Model-View-ViewModel)

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
containerView.backgroundColor = UIColor.red

var disposeBag = DisposeBag()

let frame = CGRect(x: 50, y: 100, width: 200, height: 200)
let button = UIButton(frame: frame)
button.backgroundColor = UIColor.yellow
button.setTitle("Press me!", for: UIControlState.normal)
button.setTitleColor(UIColor.black, for: UIControlState.normal)
button.titleLabel?.numberOfLines = 0
button.titleLabel?.textAlignment = .center
button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
containerView.addSubview(button)

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true

button.rx.tap
.subscribe(onNext: { tap in
    
    print("Tap")
}).addDisposableTo(disposeBag)



func runExample() {
    
    // OBSERVABLE //
    
    let observable = Observable<String>.create { (observer) -> Disposable in
        DispatchQueue.global(qos: .default).async {
            Thread.sleep(forTimeInterval: 10)
            observer.onNext("Hello dummy 🐣 from the beginning")
            observer.onCompleted()
        }
        return Disposables.create()
    }        
    // OBSERVER //
    
    observable.subscribe(onNext: { (element) in
        print(element)
    }).addDisposableTo(disposeBag)       
}


runExample()

//Observable Just
let observable = Observable<String>.just("Hello again dummy 🐥");
observable.subscribe(onNext: { (element) in
    print(element)
}).addDisposableTo(disposeBag)

observable.subscribe(onCompleted: { 
    print("I'm done")
}).addDisposableTo(disposeBag)


//Observable Interval
let observableInterval = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
observableInterval
    .take(10)
    .subscribe(onNext: { (element) in
    print(element)
},onCompleted: { (element) in 
    print("completed interval")
}).addDisposableTo(disposeBag)

//Observable repeat
let observableRepeat = Observable<String>.repeatElement("This is fun 🙄")
.take(10)
observableRepeat.subscribe(onNext: { (element) in
    print(element)
},onCompleted: { (element) in 
    print("completed repeat")
}).addDisposableTo(disposeBag)


class GoogleModel {
    func createGoogleDataObservable() -> Observable<String> {
        
        return Observable<String>.create({ (observer) -> Disposable in
            
            let session = URLSession.shared
            let task = session.dataTask(with: URL(string:"https://www.google.com")!) { (data, response, error) in
                
                // We want to update the observer on the UI thread
                DispatchQueue.main.async {
                    if let err = error {
                        // If there's an error, send an Error event and finish the sequence
                        observer.onError(err)
                    } else {
                        if let googleString = String(data: data!, encoding: .ascii) {
                            //Emit the fetched element
                            observer.onNext(googleString)
                        } else {
                            //Send error string if we weren't able to parse the response data
                            observer.onNext("Error! Unable to parse the response data from google!")
                        }
                        //Complete the sequence
                        observer.onCompleted()
                    }
                }
            }
            
            task.resume()
            
            //Return an AnonymousDisposable
            return Disposables.create(with: {
                //Cancel the connection if disposed
                task.cancel()
            })
        })
    }
}

let model = GoogleModel()
model.createGoogleDataObservable()
.subscribe(onNext: { (element) in
    //button.setTitle(element, for: UIControlState.normal)
}).addDisposableTo(disposeBag)
