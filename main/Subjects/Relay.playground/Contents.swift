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
import RxCocoa

/*:
 # Relay
 */
// Relay는 Subject를 랩핑하고 있음
// next 이벤트만 전달
// completed,error는 없음
// 구독자가 disposed 되기 전까지
// 주로 UI에 사용
let bag = DisposeBag()


let pRelay = PublishRelay<Int>()
pRelay.subscribe {
    print("1: \($0)")
}
.disposed(by: bag)

pRelay.accept(1) //onNext 대신에 accept 사용

let bRelay = BehaviorRelay(value: 1)
bRelay.accept(2)

bRelay.subscribe {
    print("2: \($0)")
}
.disposed(by: bag)

bRelay.accept(3)

print(bRelay.value) // get-only
