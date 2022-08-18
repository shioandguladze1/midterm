//
//  Result.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 12.08.22.
//

import Foundation

protocol Result { }

struct SuccessResult<T>: Result{
    let data: T
}

struct ErrorResult: Result{
    let errorMessage: String
}

