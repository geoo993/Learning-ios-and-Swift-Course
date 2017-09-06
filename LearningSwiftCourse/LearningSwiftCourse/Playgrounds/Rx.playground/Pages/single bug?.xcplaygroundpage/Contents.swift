//: [Previous](@previous)

import RxSwift
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class AudioMachine {
    enum State { case Inactive, Starting, Listening, Stopping, Error }
    enum Event { case DidStart, DidStop }
    enum Command { case Start(String); case Stop }
    
    let state = Variable(State.Inactive)
    let event = PublishSubject<Event>()
    let command = PublishSubject<Command>()
    let commandPipeline = PublishSubject<Observable<State>>()
    
    init() {
        state.asObservable()
        .subscribeNext { state in
            //print(state) 
        }
        commandPipeline.asObservable()
        .switchLatest()
        .catchError { err in Observable.just(State.Error) }
        .subscribeNext { state in 
            //print("pipeline state: \(state)")
         }
        
        setupStateMachine()
    }  
    func setupStateMachine() {
        event
        .subscribeNext { event in
            switch self.state.value {
            case .Starting: switch event {
                case .DidStart: self.state.value = .Listening
                default: break
                }
            case .Stopping: switch event {
                case .DidStop: self.state.value = .Inactive
                default: break
                }
            default: break
            }
        }
        
        command
        .subscribeNext { command in 
            switch self.state.value {
            case .Inactive: switch command {
                case .Start: 
                    self.state.value = .Starting
                default: break
                }
            case .Starting, .Listening: switch command {
                case .Stop: 
                    self.state.value = .Stopping
                default: break
                }
            case .Stopping, .Error: break
            }
        } 
    } 
    func start(task: String) { 
        commandPipeline.onNext( 
            state.asObservable()
            .take(1)
            .debug("start")
            .doOnNext { state in
                //print("do .Start(\"\(task)\")")
                self.command.onNext(.Start(task))
            }
        )
    }
    func stopWithSingle() { 
        commandPipeline.onNext(
            state.asObservable()
            .single()
            .debug("single")
            .doOnNext { state in
                //print("do .Stop")
                self.command.onNext(.Stop) 
            }
        )
    }
    func stopWithTake1() { 
        commandPipeline.onNext(
            state.asObservable()
            .take(1)
            .debug("take(1)")
            .doOnNext { state in
                self.command.onNext(.Stop) 
            }
        )
    }
}

func runTestWithSingle() {
        print(__FUNCTION__)
        let audioMachine = AudioMachine()
        audioMachine.start("First")
        audioMachine.event.onNext(.DidStart)
        audioMachine.stopWithSingle()
}
func runTestWithTake1() {
        print(__FUNCTION__)
        let audioMachine = AudioMachine()
        audioMachine.start("First")
        audioMachine.event.onNext(.DidStart)
        audioMachine.stopWithTake1()
}
runTestWithSingle()
runTestWithTake1()

print("\n== Finished 😀 ==")

//: [Next](@next)
