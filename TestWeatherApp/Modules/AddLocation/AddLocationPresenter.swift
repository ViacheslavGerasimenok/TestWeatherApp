//
//  AddLocationPresenter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import Foundation

typealias AddLocationOut = (AddLocationOutCmd) -> Void
enum AddLocationOutCmd {

}

protocol AddLocationPresenter: AnyObject {
    func viewDidLoad()
}

final class AddLocationPresenterImpl {
    
    // MARK: - Properties
    
    private let out: AddLocationOut
    private weak var view: AddLocationView?
    
    // MARK: - Init
    
    init(
        view: AddLocationView?,
        out: @escaping AddLocationOut
    ) {
        self.out = out
        self.view = view
    }
}

// MARK: - AddLocationPresenter

extension AddLocationPresenterImpl: AddLocationPresenter {
    func viewDidLoad() {
        
    }
}
