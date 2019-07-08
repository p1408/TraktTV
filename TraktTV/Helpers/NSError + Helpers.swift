//
//  NSError + Helpers.swift
//  Fuso
//
//  Created by Juan Carlos Guillén Castro on 12/17/18.
//  Copyright © 2018 Peru Apps. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(domain:String, code:Int, message:String) {
        let userInfo = [NSLocalizedDescriptionKey:message, NSLocalizedFailureReasonErrorKey:message, NSLocalizedRecoverySuggestionErrorKey:message]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
}
