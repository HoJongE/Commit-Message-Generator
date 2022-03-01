//
//  Lodable.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

enum Lodable<T>{
    case Empty
    case Loading
    case Success(data : T)
    case Error(error : Error)
    
    var value : T? {
        switch self {
            case .Success(data: let data):
                return data
            default: return nil
        }
    }
    
    var error : Error? {
        switch self {
            case .Error(error: let error):
                return error
            default: return nil
        }
    }
    
    var loading : Bool {
        switch self {
            case .Loading: return true
            default : return false
        }
    }
}

extension Lodable : Equatable {
    
    static func == (lhs:Lodable, rhs:Lodable) -> Bool {
        switch (lhs,rhs){
            case (Lodable.Empty,Lodable.Empty),
                (Lodable.Loading,Lodable.Loading),
                (Lodable.Success(data: _),Lodable.Success(data: _)),
                (Lodable.Error(error: _),Lodable.Error(error: _)):
                return true
            default:
                return false
        }
    }
    
}
extension Lodable : CustomStringConvertible where T:CustomStringConvertible {
    var description: String {
        switch self {
            case .Error(error: let error):
                #if DEBUG
                print(error)
                #endif
                return "data is error : \(error.localizedDescription)"
                
            case .Loading: return "data is Loading"
            case .Empty: return "data is Empty"
            case .Success(data: let data): return data.description
        }
    }
}