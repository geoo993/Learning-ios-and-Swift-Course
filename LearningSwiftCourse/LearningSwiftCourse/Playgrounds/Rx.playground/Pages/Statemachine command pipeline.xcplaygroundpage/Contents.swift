//: [Previous](@previous)

import RxSwift
import RxCocoa
import XCGLogger

let log : XCGLogger = { 
    let log = XCGLogger(identifier: "P", includeDefaultDestinations: true)
    log.setup(.Verbose, showLogIdentifier: false, showFunctionName: false, showThreadName: false, 
                showLogLevel: false, showFileNames: false, showLineNumbers: false, showDate: false)
    log.xcodeColorsEnabled = true
    log.xcodeColors = [
        .Verbose: XCGLogger.XcodeColor.darkGreen,
        .Debug: XCGLogger.XcodeColor.black,
        .Info: XCGLogger.XcodeColor.blue,
        .Warning: XCGLogger.XcodeColor.orange,
        .Error:XCGLogger.XcodeColor.red,
        .Severe: XCGLogger.XcodeColor.whiteOnRed
    ]
    return log }()
    
class Speech : NSObject {
    enum State { case Inactive, Starting, Listening, Stopping }
    enum Event { case DidStart, DidStop }
    enum Command { case Start(String); case Stop(Int) }
    enum SpeechError : ErrorType { case StateTransitionError }
    
    let state = Variable(State.Inactive)
    let event = PublishSubject<Event>()
    let command = PublishSubject<Command>()
    let commandPipeline = PublishSubject<Observable<State>>()
    
    override init() {
        //startVar = Variable(state.asObservable())
        
        super.init()
        let (t4, t8) = ("\t" * 4, "\t" * 8)
        state.asObservable().subscribeNext { log.info("\($0)") }
        command.asObservable().subscribeNext { log.verbose("\(t4)\($0)") }
        event.asObservable().subscribeNext { log.debug("\(t8)\($0)") }
        
        commandPipeline.asObservable().switchLatest().subscribeNext { arg in
        }
        
        setupStateMachine()
    }  
    func error(state: State, _ event: Event) {
        let t12 = "\t" * 12
        log.error("\(t12)Unrecognized \(state) -> \(event)")
    }
    func error(state: State, _ command: Command) {
        let t12 = "\t" * 12
        log.error("\(t12)Unrecognized \(state) -> \(command)")
    }
    

}
// setupStateMachine
extension Speech {   
    func setupStateMachine() {
        event
        .takeUntil(self.rx_deallocated)
        .subscribeNext { event in
            switch self.state.value {
            case .Starting: switch event {
                case .DidStart: self.state.value = .Listening
                default: self.error(self.state.value, event)
                }
            case .Stopping: switch event {
                case .DidStop: self.state.value = .Inactive
                default: self.error(self.state.value, event)
                }
            default: self.error(self.state.value, event)
            }
        }
        
        command
        .takeUntil(self.rx_deallocated)
        .subscribeNext { command in 
            switch self.state.value {
            case .Inactive: switch command {
                case .Start: self.state.value = .Starting
                default: self.error(self.state.value, command)
                }
            case .Starting, .Listening: switch command {
                case .Stop: self.state.value = .Stopping
                default: self.error(self.state.value, command)
                }
            case .Stopping: break
            }
        } 
    } 
}
// start / stop
extension Speech {
    func start(task: String) { 
        // TODO: Consider whether we can remove the if clause here.
        //if case .Inactive = state.value {
            //command.onNext(.Start(task)) 
        //} else {
            commandPipeline.onNext( 
                state.asObservable()
                .filter { $0 == .Inactive }
                .take(1)
                .doOnNext { state in
                    self.command.onNext(.Start(task))
                }
            )
        //}
    }
    func stop(idx: Int) { 
        // TODO: Consider whether we can remove the if clause here.
        //if case .Listening = state.value {
            //command.onNext(.Stop)
        //} else {
            commandPipeline.onNext(//value =
                state.asObservable()
                .filter { $0 == .Starting || $0 == .Listening }
                .take(1)
                //.catchError { err in 
                    //err 
                    //return self.state.asObservable() 
                    //} 
                //.debug()
                .doOnNext { state in
                    //log.error("state: \(state); .Stop(\(idx))")
                    self.command.onNext(.Stop(idx)) 
                }
            )
        //}
    }
}

extension Speech {
    func runTest() {
        start("First")
        event.onNext(.DidStart)
        start("Second")
        stop(1)
        start("Third")
        stop(2)
        event.onNext(.DidStop)
        start("Forth")
        event.onNext(.DidStart)
        stop(3)
        event.onNext(.DidStop)
        start("Fifth")
        event.onNext(.DidStart)
        stop(4)
        event.onNext(.DidStop)

    }
}

let speech = Speech()

speech.runTest()
let success = speech.state.value == .Inactive ? "😀" : "😫"

print("\n== Finished \(success) ==")

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: [Next](@next)
