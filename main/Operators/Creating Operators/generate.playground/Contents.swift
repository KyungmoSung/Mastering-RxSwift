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
//  OUT OF OR IN CONNECTION WITH THE SOFTWAR   E OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # generate
 */

let disposeBag = DisposeBag()
let red = "🔴"
let blue = "🔵"

// 시작값, 조건, 증가값
// 0~10까지 2씩 증가하는 옵저버블
Observable.generate(initialState: 0, condition: { $0 <= 10 }, iterate: { $0 + 2 })
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

// 10~0까지 2씩 감소하는 옵저버블
Observable.generate(initialState: 10, condition: { $0 >= 0}, iterate: { $0 - 2 })
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

// 빨간,파란공을 번갈아 방출하는 옵저버블
Observable.generate(initialState: red, condition: { $0.count < 15 }, iterate: { $0.count.isMultiple(of: 2) ? $0 + red : $0 + blue })
    .subscribe{ print($0) }
    .disposed(by: disposeBag)



