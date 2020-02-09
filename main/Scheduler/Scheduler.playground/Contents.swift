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
 # Scheduler
 */

// 스케줄러는 특정코드가 실행되는 컨텍스트를 추상화한것
// 컨텍스트는 로우레벨 Thread가 될 수도 잇고 Dispatch Queue, Operation Queue가 될 수도 있음
// 추상화된 컨텍스트이기 때문에 쓰레드와 1대1로 매칭되지 않음

let bag = DisposeBag()

let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .subscribeOn(MainScheduler.instance) //시퀀시가 시작될때 어느 스케줄러에서 실행될지 지정(최상위부터 적용)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main" : "Background", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observeOn(backgroundScheduler) //다음에 오는 작업들이 어느 스케줄러에서 실행될지 지정(하위부터 적용)
    .map { num -> Int in
        print(Thread.isMainThread ? "Main" : "Background", ">> map")
        return num * 2
    }
    .observeOn(MainScheduler.instance)
    .subscribe {
        print(Thread.isMainThread ? "Main" : "Background", ">> subscribe",$0)
    }
    .disposed(by: bag)





