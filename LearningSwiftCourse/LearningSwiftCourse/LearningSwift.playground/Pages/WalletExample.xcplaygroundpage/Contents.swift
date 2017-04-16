//: [Previous](@previous)

import Foundation
import UIKit
import RxCocoa
import RxSwift
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
containerView.backgroundColor = UIColor.blue

var disposeBag = DisposeBag()


struct AutoResponse {
    var userId : String
}
struct UserModel {
    var userName : String
    var funFact : String
    var creditCardProcessoruserId : String
}
struct UserCreditCardAccountResponse {
    var isValid : Bool
    var creditCardIds : [String]
}

struct CreditCardInfo {
    var creditCardId : String
    var expirationTimestamp : TimeInterval
}

protocol SampleService {
    
    func rx_login(userName:String, password: String) -> Observable<AutoResponse>
    func rx_getUserInfo(userId:String) -> Observable<AutoResponse>
    func rx_getCreaditCardAccount(userId:String) -> Observable<UserCreditCardAccountResponse>
    func rx_getAllCreditCards(creditCardId:String) -> Observable<[CreditCardInfo]>
}

class UserService {
    
    func GetCreditCards()
    {
        
        let sampleService = [] as! SampleService
        sampleService.self.rx_login(userName:"max",password: "helloworld" )
        .flatMap { (autoResponse) -> Observable<UserCreditCardAccountResponse> in
            return sampleService.rx_getCreaditCardAccount(userId:autoResponse.userId)
        }
        .flatMap { (userCreditCardResponse) -> Observable<[CreditCardInfo]> in
            return sampleService.rx_getAllCreditCards(creditCardId:userCreditCardResponse.creditCardIds[0]) 
        }
        .subscribe(onNext:{ creditCards in
            print(creditCards)
                
        })
        
    }
}

extension Int {
    public static func random(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}


func rx_Buy(stockPulse: Int, accountBalance: Double) -> Observable<Bool> {
    let pricePerUnit : Double = 50.0
    
    return Observable.of(stockPulse)
        .map { orders in
            Double(orders) * pricePerUnit
        }
        .map{ total in
            print("total", total)
            
            print("accountBalance", accountBalance)
            return total < accountBalance
    }
}


var tapResult = Int.random(min:1, max: 10)
var bal = Int.random(min:100, max: 400)
var buttons : [UIButton] = []

let walletLabel = UILabel(frame: CGRect(x: 60, y: 40, width: 150, height: 40))
walletLabel.backgroundColor = UIColor.gray
walletLabel.text = "    Wallet:  £ \(Double(bal))"


let textfieldbox = UITextField(frame: CGRect(x: 30, y: 150, width: 250, height: 40))
textfieldbox.backgroundColor = UIColor.white
textfieldbox.font = UIFont.systemFont(ofSize: 12)

let pressMeButton = UIButton(frame: CGRect(x: 30, y: 200, width: 250, height: 80))
pressMeButton.backgroundColor = UIColor.green
pressMeButton.setTitle("Press me", for: UIControlState.normal)
pressMeButton
.rx
.tap
.subscribe(onNext: { tap in
    
    print(tap, "button tapped = you can buy item ") 
}).addDisposableTo(disposeBag)


for i in 0...5
{
    let butts = UIButton(frame: CGRect(x: 30 + CGFloat(i % 6) * CGFloat(40), y: 350, width: 30, height: 30))
    butts.setTitle("\(i+1)", for: UIControlState.normal)
    butts.backgroundColor = UIColor.brown
    buttons.append(butts)
    
}


buttons.forEach { button in
    
    // tapResult transforms the button tap into an Int of the currentTitle
    let tapResult = 
        button
            .rx
            .tap
            .map { _ in Int(button.currentTitle!)! }

    tapResult    
        .flatMap { tapRes -> Observable<Bool> in            
            print(tapRes)
            return rx_Buy( stockPulse: tapRes, accountBalance: Double(bal))
            
        }
        // doOnNext allow for side-effects.
        .do( onNext: { canBuy in
            pressMeButton.backgroundColor = 
                canBuy ? UIColor.green : UIColor.red
        })
        // finally bind our rx_Buy observable to button.enabled
        .bindTo(button.rx.isEnabled)
    
    tapResult
        .map { result in "  Number of Items: \(result) (Total: £ \(result * 50))" }
        // binds transformed tapResult text to textfieldbox.text
        .bindTo(textfieldbox.rx.text)
    
    containerView.addSubview(button)
    
}

containerView.addSubview(walletLabel)
containerView.addSubview(textfieldbox)
containerView.addSubview(pressMeButton)






PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true
