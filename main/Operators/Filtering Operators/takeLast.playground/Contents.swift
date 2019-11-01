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
 # takeLast
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 정수를 파라미터로 받아서 옵저버블을 리턴
// 리턴되는 옵저버블에는 원본 옵저버블이 방출하는 요소중에서 마지막에 방출된 N개의 요소가 포함되어 있음
// 구독자로 전달되는 시점이 Delay됨

let subject = PublishSubject<Int>()

 subject
     .takeLast(2)
     .subscribe{ print($0) }
     .disposed(by: disposeBag)

 numbers.forEach {
     subject.onNext($0)
 }
enum MyError: Error {
    case error
}
//subject.onCompleted() //버퍼에 저장된 요소가 구독자에게 방출됨
subject.onError(MyError.error) // 에러가 발생한 경우 요소가 방출되지 않고 에러 이벤트만 방출
