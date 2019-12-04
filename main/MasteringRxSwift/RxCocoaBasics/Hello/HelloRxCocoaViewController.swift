//
//  HelloRxCocoaViewController.swift
//  MasteringRxSwift
//
//  Created by Keun young Kim on 26/08/2019.
//  Copyright © 2019 Keun young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HelloRxCocoaViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var tapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let words = ["Apple","Banana","Orange","Book","City","Axe"]

        Observable.range(start: 1, count: 10)
            .groupBy{ $0.isMultiple(of: 2) }
            .flatMap{ $0.toArray() }
            .subscribe{ print($0) }
            .disposed(by: disposeBag)
    }
}
