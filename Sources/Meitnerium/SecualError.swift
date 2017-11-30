//
//  SecualError.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/11/29.
//

import Foundation

enum SecualError: Error {
    case noJsonObject(String)
    case noParameter(String)
    case invalidFormat(String)
    case invalidValue(String)
}
