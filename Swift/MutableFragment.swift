//
//  MutableFragment.swift
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

/// MutableFragmentProtocol provides read and write access to the data value
/// wrapped by a fragment object.
public protocol MutableFragmentProtocol: FragmentProtocol {
    
    var value: Any? { get set }
    
    var string: String? { get set }
    
    var number: NSNumber? { get set }
    
    var int: Int { get set }
    
    var int64: Int64 { get set }
    
    var float: Float { get set }
    
    var double: Double { get set }
    
    var boolean: Bool { get set }
    
    var date: Date? { get set }
    
    var blob: Blob? { get set }
    
    var array: MutableArrayObject? { get set }
    
    var dictionary: MutableDictionaryObject? { get set }
    
}

/// MutableArrayFragment protocol provides subscript access to Fragment objects
/// by index.
public protocol MutableArrayFragment {
    subscript(index: Int) -> MutableFragment { get }
}

/// MutableDictionaryFragment protocol provides subscript access to
/// CBLMutableFragment objects by key.
public protocol MutableDictionaryFragment {
    subscript(key: String) -> MutableFragment { get }
}

/// MutableFragment provides read and write access to data value. MutableFragment also provides
/// subscript access by either key or index to the nested values which are wrapped by
/// MutableFragment objects.
public final class MutableFragment: Fragment, MutableDictionaryFragment, MutableArrayFragment {
    
    /// Gets the value from or sets the value to the fragment object.
    public override var value: Any? {
        get {
            return DataConverter.convertGETValue(fragmentImpl.value)
        }
        set {
            fragmentImpl.value = (DataConverter.convertSETValue(newValue) as? NSObject)
        }
    }
    
    /// Gets the value as string or sets the string value to the fragment object.
    public override var string: String? {
        get {
            return fragmentImpl.string
        }
        set {
            fragmentImpl.string = newValue
        }
    }
    
    /// Gets the value as number or sets the number value to the fragment object.
    public override var number: NSNumber? {
        get {
            return fragmentImpl.number
        }
        set {
            fragmentImpl.number = newValue
        }
    }
    
    /// Gets the value as integer or sets the integer value to the fragment object.
    public override var int: Int {
        get {
            return fragmentImpl.integerValue
        }
        set {
            fragmentImpl.integerValue = newValue
        }
    }
    
    /// Gets the value as integer or sets the integer value to the fragment object.
    public override var int64: Int64 {
        get {
            return fragmentImpl.longLongValue
        }
        set {
            fragmentImpl.longLongValue = newValue
        }
    }
    
    /// Gets the value as float or sets the float value to the fragment object.
    public override var float: Float {
        get {
            return fragmentImpl.floatValue
        }
        set {
            fragmentImpl.floatValue = newValue
        }
    }
    
    /// Gets the value as double or sets the double value to the fragment object.
    public override var double: Double {
        get {
            return fragmentImpl.doubleValue
        }
        set {
            fragmentImpl.doubleValue = newValue
        }
    }
    
    /// Gets the value as boolean or sets the boolean value to the fragment object.
    public override var boolean: Bool {
        get {
            return fragmentImpl.booleanValue
        }
        set {
            fragmentImpl.booleanValue = newValue
        }
    }
    
    /// Gets the value as blob or sets the blob value to the fragment object.
    public override var date: Date? {
        get {
            return fragmentImpl.date
        }
        set {
            fragmentImpl.date = newValue
        }
    }
    
    /// Gets the value as blob or sets the blob value to the fragment object.
    public override var blob: Blob? {
        get {
            return DataConverter.convertGETValue(fragmentImpl.blob) as? Blob
        }
        set {
            fragmentImpl.blob = (DataConverter.convertSETValue(newValue) as? CBLBlob)
        }
    }
    
    /// Get the value as an MutableArrayObject object, a mapping object of an array value.
    /// Returns nil if the value is nil, or the value is not an array.
    public override var array: MutableArrayObject? {
        get {
            return DataConverter.convertGETValue(fragmentImpl.array) as? MutableArrayObject
        }
        set {
            fragmentImpl.array = (DataConverter.convertSETValue(newValue) as? CBLMutableArray)
        }
    }
    
    /// Get a property's value as a MutableDictionaryObject object, a mapping object of
    /// a dictionary value. Returns nil if the value is nil, or the value is not a dictionary.
    public override var dictionary: MutableDictionaryObject? {
        get {
            return DataConverter.convertGETValue(fragmentImpl.dictionary) as? MutableDictionaryObject
        }
        set {
            fragmentImpl.dictionary = (DataConverter.convertSETValue(newValue) as? CBLMutableDictionary)
        }
    }
    
    // MARK: Subscripts
    
    /// Subscript access to a MutableFragment object by index.
    ///
    /// - Parameter index: The index.
    public override subscript(index: Int) -> MutableFragment {
        return MutableFragment((fragmentImpl as CBLMutableArrayFragment)[UInt(index)])
    }
    
    /// Subscript access to a MutableFragment object by key.
    ///
    /// - Parameter key: The key.
    public override subscript(key: String) -> MutableFragment {
        return MutableFragment((fragmentImpl as CBLMutableDictionaryFragment)[key])
    }
    
    // MARK: Internal
    
    init(_ impl: CBLMutableFragment?) {
        super.init(impl ?? MutableFragment.kNonexistent)
    }
    
    // MARK: Private
    
    private var fragmentImpl: CBLMutableFragment {
        return impl as! CBLMutableFragment
    }

    static let kNonexistent = CBLMutableFragment()

}
