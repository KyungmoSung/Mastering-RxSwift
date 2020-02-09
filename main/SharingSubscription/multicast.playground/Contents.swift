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
 # multicast
 */

// subject를 파라미터로 받음
// 이벤트는 구독자에게 전달되는것이 아니라 subject로 전달됨
// 전달받은 이벤트를 다수의 구독자에게 전달함
// 유니캐스트방식으로 동작하는 옵져버블을 멀티캐스트방식으로 바꿔줌
// ConnectableObservable을 리턴
// 구독자가 추가되어도 시퀀스가 시작되지 않음
// connect 매소드를 호출하는 시점에 시퀀스 시작
// 모든 구독자가 등록된 이후에 하나의 시퀀시를 시작하는 패턴
// subject를 직접 만들고 connect 메소드를 직접 호출해야되기 때문에 번거로움

let bag = DisposeBag()
let subject = PublishSubject<Int>()

let source = Observable<Int>
  .interval(.seconds(1), scheduler: MainScheduler.instance)
  .take(5)
  .multicast(subject)

source
  .subscribe { print("🔵", $0) }
  .disposed(by: bag)

source
  .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
  .subscribe { print("🔴", $0) } // 구독이 지연된동안 원본 옵저버블이 전달한 2개의 이벤트는 전달되지 않음
  .disposed(by: bag)

source
  .connect() // 시퀀스가 시작됨
  .disposed(by: bag)






