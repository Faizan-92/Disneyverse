//
//  BaseRequest.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import Alamofire

extension Request {
   public func debug() -> Self {
       Logger.log(self.description)
       return self
   }
}
