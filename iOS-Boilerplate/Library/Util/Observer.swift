//
//  Observer.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 23/03/2020.
//  Copyright © 2020 veladan. All rights reserved.
//

protocol Observer {
  associatedtype Value
  func update(value: Value)
}

class AnyObserver<Value>: Observer {
  private let updateClosure: (Value) -> Void

  init<ObserverType: Observer>(with observer: ObserverType) where ObserverType.Value == Value {
    self.updateClosure = observer.update
  }

  func update(value: Value) {
    self.updateClosure(value)
  }
}

extension Observer {
  func toAnyObserver() -> AnyObserver<Value> {
    AnyObserver<Value>(with: self)
  }
}

// protocol Subject {
//  associatedtype Value
//  mutating func add(observer: AnyObserver<Value>)
//  mutating func remove(observer: AnyObserver<Value>)
//  func fireNotification()
// }
//
// class UserView {
//  func render(user: User) {
//    print("User is now: \(user)")
//  }
// }
//
// extension UserView: Observer {
//  func update(value: User) {
//    self.render(user: value)
//  }
// }
//
// @propertyWrapper
// struct Observed<Value>: Subject {
//  init(initialValue: Value) {
//    self.value = initialValue
//  }
//
//  var value: Value {
//    didSet {
//      self.fireNotification()
//    }
//  }
//
//  var observers = [AnyObserver<Value>]()
//
//  mutating func add(observer: AnyObserver<Value>) {
//    self.observers.append(observer)
//  }
//
//  mutating func remove(observer: AnyObserver<Value>) {
//    self.observers.removeAll { $0 === observer }
//  }
//
//  func fireNotification() {
//    self.observers.forEach { $0.update(value: self.value) }
//  }
// }
//
// struct SampleClass {
//  @Observed
//  var user = User()
//
//  mutating func run() {
//    let userView = UserView()
//    $user.add(observer: userView.toAnyObserver())
//
//    user.name = "Phoenix"
//  }
//
// }
