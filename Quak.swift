//
//  Quak.swift
//  Contly
//
//  Created by Moses Adeoye Ayankoya on 26/06/2017.
//  Copyright © 2017 Flint. All rights reserved.
//


import Foundation


extension String {
    
    public var isWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    public var isNotEmpty: Bool {
        return !self.isWhiteSpace
    }
    
    
    func abbrevate() -> String {
        guard self.characters.count > 0 else { return "" }
        
        let strs = self.components(separatedBy: " ")
        let first = strs.first!
        guard strs.count > 1 else { return "\(first.characters.first!)".uppercased() }
        let last = strs.last!
        
        return  first.isEmpty ? "" : "\(first.characters.first!)".uppercased()  + (last.isEmpty ? "" : "\(last.characters.first!)".uppercased())
    }
}

public enum QueryOperator : String {
    case or = "OR", and = "AND"
}


open class Quak{
    
    private var _query:String = ""
    
    public init(){}
    
    public convenience init(query: String = ""){
        self.init()
        self._query = query
    }
    
    open func toString() -> String{
        return _query
    }
    
    open func isNil(key:String) -> Quak{
        _query = _query + "\(key) == nil"
        return self
    }
    
    open func isNotNil(key:String) -> Quak{
        _query = _query + "\(key) != nil"
        return self
    }
    
    open func isNotBetween(key:String, leftValue:Any, rightValue:Any) -> Quak {
        return not(isBetween(key: key, leftValue: leftValue, rightValue: rightValue))
    }
    
    open func isBetween(key:String, leftValue:Any, rightValue:Any) -> Quak{
        _query = _query + " \(key) BETWEEN \(leftValue) AND \(rightValue)"
        return self
    }
    
    open func isNotIn(key:String, values:[Any]) -> Quak{
        return not(isIn(key: key, values: values))
    }
    
    open func isIn(key:String, values:[Any]) -> Quak{
        var temp = ""
        values.forEach { (val) in
            temp = temp + (temp.isWhiteSpace ? "" : ",") + "'\(val)'"
        }
        _query = _query + " \(key) IN {\(temp)}"
        return self
    }
    
    open func notEqual(key:String, value:Any) -> Quak{
        return not(equal(key: key, value: value))
    }
    
    open func equal(key:String, value:Any) -> Quak{
        
        _query = _query + "\(key) ==  \((value is String) ?  "'\(value)'" : "\(value)")"
        return self
    }
    
    open func beginsWith(key:String, value:Any) -> Quak{
        _query = _query + " \(key) BEGINSWITH \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func endsWith(key:String, value:Any) -> Quak{
        _query = _query + " \(key) ENDSWITH \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func notBeginsWith(key:String, value:Any) -> Quak{
        return not(beginsWith(key: key, value: value))
    }
    
    open func notEndsWith(key:String, value:Any) -> Quak{
        return not(endsWith(key: key, value: value))
    }
    
    open func notContains(key:String, value:Any) -> Quak{
        return not(contains(key: key, value: value))
    }
    
    open func contains(key:String, value:Any) -> Quak{
        _query = _query + " \(key) CONTAINS \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func notLike(key:String, value:Any) -> Quak{
        return not(like(key: key, value: value))
    }
    
    open func like(key:String, value:Any) -> Quak{
        _query = _query + " \(key) LIKE \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func any(_ operand:Quak) -> Quak {
        _query = _query + " ANY (\(operand.toString()))"
        return self
    }
    
    open func greaterThan(key:String, value:Any) -> Quak{
        _query = _query + " \(key) > \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func lessThan(key:String, value:Any) -> Quak{
        _query = _query + " \(key) < \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func greaterThanOrEqual(key:String, value:Any) -> Quak{
        _query = _query + " \(key) >= \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func lessThanOrEqual(key:String, value:Any) -> Quak{
        _query = _query + " \(key) <= \((value is String) ? "'\(value)'" : "\(value)")"
        return self
    }
    
    open func notGreaterThan(key:String, value:Any) -> Quak{
        return not(greaterThan(key: key, value: value))
    }
    
    open func notLessThan(key:String, value:Any) -> Quak{
        return not(lessThan(key: key, value: value))
    }
    
    open func notGreaterThanOrEqual(key:String, value:Any) -> Quak{
        return not(greaterThanOrEqual(key: key, value: value))
    }
    
    open func notLessThanOrEqual(key:String, value:Any) -> Quak{
        return not(lessThanOrEqual(key: key, value: value))
    }
    
    open func not(_ operand: Quak) -> Quak {
        _query = _query + " NOT (\(operand.toString()))"
        return self
    }
    
    open func or() -> Quak{
        _query = _query + " OR "
        return self
    }
    
    open func and() -> Quak{
        _query = _query + " AND "
        return self
    }
    
    fileprivate func or(left:Quak, right: Quak) -> Quak{
        _query = _query + " \(left.toString()) OR \(right.toString())"
        return self
    }
    
    fileprivate func and(left:Quak, right:Quak) -> Quak{
        _query = _query + " \(left.toString()) AND \(right.toString())"
        return self
    }
}
