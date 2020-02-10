//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # retryWhen
 */
// 사용자가 재시도 버튼을 탭할때만 재시도를 할 경우
// 클로저를 파라미터로 받고 TriggerObservable 리턴
let bag = DisposeBag()

enum MyError: Error {
   case error
}

var attempts = 1

let source = Observable<Int>.create { observer in
   let currentAttempts = attempts
   print("START #\(currentAttempts)")
   
   if attempts < 3 {
      observer.onError(MyError.error)
      attempts += 1
   }
   
   observer.onNext(1)
   observer.onNext(2)
   observer.onCompleted()
   
   return Disposables.create {
      print("END #\(currentAttempts)")
   }
}

let trigger = PublishSubject<Void>()

source
  .retryWhen { _ in trigger }
   .subscribe { print($0) }
   .disposed(by: bag)

trigger.onNext(()) // triggerObservable에서 next 이벤트가 전달될때 재시도
trigger.onNext(())

