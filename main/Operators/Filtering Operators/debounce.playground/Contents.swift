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
 # debounce
 */

let disposeBag = DisposeBag()

// 파라미터에 전달하는 시간은 연산자가 next 이벤트를 방출할지 결정하는 조건으로 사용됨
// 옵저버가 next 이벤트를 방출한다음 지정된 시간동안 이벤트를 방출하지 않는다면 해당시점에 가장 마지막으로 방출된 next이벤트를 구독자에게 전달함
// 반대로 지정된 시간 이내에 또 다른 next이벤트를 방출했다면 타이머를 초기화함
// 타이머를 초기화한후 다시 지정된 시간만큼 대기
// 이 시간안에 이벤트가 방출되지 않는다면 마지막 이벤트를 방출하고
// 이벤트가 방출되면 타이머를 다시 초기화

let buttonTap = Observable<String>.create{ observer in
    DispatchQueue.global().async {
        for i in 1...10 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }
        
        Thread.sleep(forTimeInterval: 1)
        
        for i in 11...20 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }
        
        observer.onCompleted()
    }
    
    
    return Disposables.create()
}

buttonTap
    .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

