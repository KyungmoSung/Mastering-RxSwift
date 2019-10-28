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
 # PublishSubject
 */
// 구독 이후에 발생한 이벤트만 전달

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = PublishSubject<String>()

subject.onNext("123") // X

let ob1 = subject.subscribe{ print("1 >> \($0)") }
ob1.disposed(by: disposeBag)

subject.onNext("456") // ob1

let ob2 = subject.subscribe{ print("2 >> \($0)") }
ob2.disposed(by: disposeBag)

subject.onNext("789") // ob1, ob2

//subject.onCompleted() // ob1, ob2
subject.onError(MyError.error)

// Completed 이후에 구독시 바로 Completed이벤트 전달, Error도 똑같음
let ob3 = subject.subscribe{ print("3 >> \($0)") }
ob3.disposed(by: disposeBag)
