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
 # share
 */

// share연산자가 리턴하는 옵저버블은 refCount옵저버블
// replay: 버퍼 사이즈
// whileConnected: 새로운 구독자(커넥션)가 추가되면 서브젝트를 생성하고 이어지는 구독자는 이 서브젝트를 공유, 커넥션이 종료되면 서브젝트는 사라지고 커넥션마다 새로운 서브젝트가 생성됨
//커넥션은 다른커넥션과 격리되어있음(isolated)
// forever: 모든 구독자(커넥션)이 하나의 서브젝트를 공유함

let bag = DisposeBag()
let source = Observable<Int>
  .interval(.seconds(1), scheduler: MainScheduler.instance)
  .debug()
  .share(replay: 5, scope: .forever)

let observer1 = source
   .subscribe { print("🔵", $0) }

let observer2 = source
   .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
   observer1.dispose()
   observer2.dispose()
  //disconnect
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
   let observer3 = source.subscribe { print("⚫️", $0) }

   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      observer3.dispose()
   }
}
