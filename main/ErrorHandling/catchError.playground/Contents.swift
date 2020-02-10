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
 # catchError
 */
//next이벤트와 completed이벤트는 구독자에게 그대로 전달
//error는 전달하지 않고 새로운 옵져버블로 교체
//네트워크 요청을 구현할때 많이 사용함

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

subject
    .catchError { _ in recovery } // 에러 발생시 recovery로 고체
   .subscribe { print($0) }
   .disposed(by: bag)

subject.onError(MyError.error)

subject.onNext(1) // 소스 옵저버블은 새로운 요소를 전달하지 못함

recovery.onNext(2) // 새로운 요소를 방출할 수 있음
recovery.onCompleted()
