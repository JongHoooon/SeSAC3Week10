//
//  PunkError.swift
//  SeSAC3Week10
//
//  Created by JongHoon on 2023/09/19.
//

import Foundation

enum PunkError: Error {
    case invalidURL
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL 입니다."
        }
    }
}
