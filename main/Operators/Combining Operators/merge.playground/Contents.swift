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
 # merge
 */

// 여러 옵저버블이 배출하는 항목들을 하나의 옵저버블에서 방출하도록 병합
// concat과 동작방식이 다름
// concat: 하나의 옵저법블이 모든요소를 방출하고 Completed을 방출하면 이어지는 옵저버블을 연결
// merge: 두개이상의 옵저버블을 병합하고 모든 옵저버블에서 방출하는 요소들을 순서대로 방출하는 옵저버블을 리턴

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

let source = Observable.of(oddNumbers, evenNumbers)

// 단순히 뒤에 연결하는것이 아니라 하나의 옵저버블로 합쳐줌
source
    .merge()
    .subscribe{ print($0) }
    .disposed(by: bag)

oddNumbers.onNext(3)
evenNumbers.onNext(4)

evenNumbers.onNext(6)
oddNumbers.onNext(5)

//oddNumbers.onCompleted() //병합한 모든 옵저버블이 Completed되면 구독자에게 Completed전달
oddNumbers.onError(MyError.error) //Error 전달, 이후 이벤트 받지 않음
evenNumbers.onNext(7)
evenNumbers.onCompleted()

