//
//  ListenerToken.swift
//  CouchbaseLite
//
//  Copyright (c) 2017 Couchbase, Inc All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import CouchbaseLiteSwift_Private

/// Listener token returned when adding a change listener. The token is used
/// for removing the added change listener.
public class ListenerToken {
    
    /// Remove the listener associated with the token.
    public func remove() {
        impl.remove()
        
        if let removedBlock = self.removedBlock {
            removedBlock(self)
        }
    }
    
    // MARK: Internal
    
    typealias RemovedBlock = (_ token: ListenerToken) -> Void
    
    init(_ impl: CBLListenerToken, removeBlock: RemovedBlock? = nil) {
        self.impl = impl
        self.removedBlock = removeBlock
    }
    
    let impl: CBLListenerToken
    
    let removedBlock: RemovedBlock?
    
}
