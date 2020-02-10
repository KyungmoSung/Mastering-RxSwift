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
 # refCount
 */

// ConnectableObservable 익스텐션에 구현되어있기 때문에 일반 Observable에서는 사용할 수 없음
// 내부에서 connect를 자동으로 호출함
// 다른 연산자는 ConnectableObservable을 직접 관리 해야하지만 (connect, dispose, take...) refCount는 자동으로 처리되기때문에 더 간편함

let bag = DisposeBag()
let source = Observable<Int>
  .interval(.seconds(1), scheduler: MainScheduler.instance)
  .debug()
  .publish()
  .refCount()

let observer1 = source
   .subscribe { print("🔵", $0) } // connect

DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 3초 후 구독 취소
   observer1.dispose() // 다른 구독자가 없기때문에 disconnect
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) { // 7초 후 구독 시작
  let observer2 = source.subscribe { print("🔴", $0) } // connect

   DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 3초 후 구독 취소
      observer2.dispose() // disconnect
   }
}








