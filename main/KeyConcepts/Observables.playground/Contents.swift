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
 # Observables
 */
// Observable 생성
//직접 리소스를 해제시키고 종료하려면 `dispose()`를 호출하면 된다.

//`DisposedBag`을 사용하여 여러개의 Disposable을 한꺼번에 관리하고 할당해제할 수 있다.

    var disposeBag = DisposeBag()
    
    Observable.from([1, 2, 3])
        .subscribe {
            print($0)
        }
        .disposed(by:disposeBag)
// #1
Observable<Int>.create { (observer) -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    
    return Disposables.create()
}

// #2
Observable.from([0,1])

let observable = Observable.from([1, 2, 3])
observable.subscribe { print($0) }










