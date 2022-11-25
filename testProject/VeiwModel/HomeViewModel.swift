//
//  HomeViewModel.swift
//  testProject
//
//  Created by YongJin on 2022/11/25.
//

import Foundation

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}


