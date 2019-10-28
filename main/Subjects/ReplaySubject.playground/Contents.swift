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
 # ReplaySubject
 */
// 2개 이상의 이벤트를 저장하고 옵저버에게 전달하고 싶을때 사용
let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let rSub = ReplaySubject<Int>.create(bufferSize: 3)

(1...10).forEach{ rSub.onNext($0) }

// 버퍼의 크기만큼 이벤트를 저장했다가 전달
rSub.subscribe{ print("Observer 1 >> ", $0) }
    .disposed(by: disposeBag)

rSub.subscribe{ print("Observer 2 >> ", $0) }
    .disposed(by: disposeBag)

// 가장 마지막 이벤트가 삭제되고 새로운 이벤트가 저장됨
rSub.onNext(11)

// 구독을 시작할때 버퍼 크긴만큼 이벤트 전달
rSub.subscribe{ print("Observer 3 >> ", $0) }
    .disposed(by: disposeBag)

rSub.onCompleted()
//rSub.onError(MyError.error)

// 이벤트 종료(Completed,error)와 상관없이 버퍼크기만큼의 이벤트 전달
// next이벤트 buffer개 + 완료이벤트(Completed,error) = 3 + 1 = 4
rSub.subscribe{ print("Observer 4 >> ", $0) }
    .disposed(by: disposeBag)


