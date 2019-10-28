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
 # BehaviorSubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let pSub = PublishSubject<Int>() // 초기값 없음
// Subject에 이벤트가 전달되기 전까지 구독자에게 이벤트가 전달되지 않음
pSub.subscribe{ print("PublishSubject >> ", $0) }
    .disposed(by: disposeBag)

let bSub = BehaviorSubject<Int>(value: 0) // 초기값을 가지고 있음
// 생성과 함께 내부에 Next이벤트가 만들어짐, 구독과함께 이벤트 전달
bSub.subscribe{ print("BehaviorSubject >> ",$0) }
    .disposed(by: disposeBag)

bSub.onNext(1)

// 새로운 next이벤트가 전달되면 기존의 이벤트를 교체 -> 최신의 Next이벤트를 옵저버에게 전달
bSub.subscribe{ print("BehaviorSubject2 >> ",$0) }
    .disposed(by: disposeBag)

//bSub.onCompleted()
bSub.onError(MyError.error)

// 마지막이벤트인 completed,error만 전달
bSub.subscribe{ print("BehaviorSubject3 >> ",$0) }
    .disposed(by: disposeBag)
