//
//  Conflict.swift
//  CouchbaseLite
//
//  Copyright (c) 2019 Couchbase, Inc All rights reserved.
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

/// Conflict class
public struct Conflict {
    
    ///The document id of the conflicting document.
    public var documentID: String {
        return toImpl().documentID
    }
    
    /// The document in the local database. If nil, document is deleted.
    public var localDocument: Document? {
        guard let doc = toImpl().localDocument else {
            return nil
        }
        
        return Document(doc, collection: col)
    }
    
    /// The document replicated from the remote database. If nil, document is deleted.
    public var remoteDocument: Document? {
        guard let doc = toImpl().remoteDocument else {
            return nil
        }
        
        return Document(doc, collection: col)
    }
    
    // MARK: Internal
    
    // Use Any to workaround
    private var impl: Any
    internal var col: Collection
    
    init(impl: Any, collection: Collection) {
        self.impl = impl
        self.col = collection
    }
    
    func toImpl() -> CBLConflict {
        return self.impl as! CBLConflict
    }
    
}
