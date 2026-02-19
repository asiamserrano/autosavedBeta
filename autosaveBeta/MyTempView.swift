//
//  MyTempView.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/19/26.
//

import SwiftUI
import Core



//public enum Letters {
//    
//    public enum AType: A {
//        
//        case c1, c2
//        
//        public var b: BType.Cases {
//            switch self {
//            case .c1: return BType.C1.cases.map(BType.c1)
//            case .c2: return BType.C2.cases.map(BType.c2)
//            }
//        }
//        
//        public enum BType: B {
//            
//            public typealias AType = Letters.AType
//            
//            case c1(C1)
//            case c2(C2)
//            
//            public var a: AType {
//                switch self {
//                case .c1: return .c1
//                case .c2: return .c2
//                }
//            }
//            
//            public var c: CType {
//                switch self {
//                case .c1(let c1): return c1
//                case .c2(let c2): return c2
//                }
//            }
//            
//            public protocol LettersC: C where BType == Letters.AType.BType {}
//            
//            public enum C1: LettersC {
//                case a, b, c
//            }
//            
//            public enum C2: LettersC {
//                case one, two, three
//            }
//            
//        }
//        
//    }
//    
//}


struct MyTempView: View {
    
    let uuid: UUID = .defaultValue
    
    var body: some View {
        NavigationStack {
            Form {
//                EnumerableView(Letters.AType.self)
//                EnumerableView(Letters.B1.self)
//                EnumerableView(Letters.B2.self)
//                EnumerableView(Letters.CType.self)
            }
            .navigationTitle(self.uuid.uuidString)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Button") {}
                })
                
            }
        }
    }
    
    @ViewBuilder
    public func EnumerableView<T: Enumerable>(_ type: T.Type) -> some View {
        Section(type.className) {
            ForEach(type.cases) {
                Text($0.rawValue)
            }
        }
    }
    
}

#Preview {
    MyTempView()
}

/*
 public protocol Letter: Enumerable {}

 public protocol A: Letter where BType.AType == Self {
     associatedtype BType: B
     
     typealias CType = Self.BType.CType
     
     var b: BType.Cases { get }
 }

 public protocol B: Letter where AType.BType == Self {
     associatedtype AType: A
     
     typealias CType = any C
     
     var c: CType { get }
     var a: AType { get }
 }

 public protocol C: Letter where Self.AType == Self.BType.AType {
     associatedtype AType: A
     associatedtype BType: B
 }

 extension B {
     
     public static var allCases: [Self] {
         AType.cases.flatMap(\.b)
     }
     
     public var compound: Compound {
         self.c.compound
     }
     
     public var rawValue: String {
         self.c.rawValue
     }
     
 }
 
 public enum Letters {
     
     public enum AType: A {
         
         case c1, c2
         
         public var b: BType.Cases {
             switch self {
             case .c1: return BType.C1.cases.map(BType.c1)
             case .c2: return BType.C2.cases.map(BType.c2)
             }
         }
         
         public enum BType: B {
             
             public typealias AType = Letters.AType
             
             case c1(C1)
             case c2(C2)
             
             public var a: AType {
                 switch self {
                 case .c1: return .c1
                 case .c2: return .c2
                 }
             }
             
             public var c: CType {
                 switch self {
                 case .c1(let c1): return c1
                 case .c2(let c2): return c2
                 }
             }
             
             public protocol LettersC: C where BType == Letters.AType.BType {}
             
             public enum C1: LettersC {
                 case a, b, c
             }
             
             public enum C2: LettersC {
                 case one, two, three
             }
             
         }
         
     }
     
 }
 */


/*
 public protocol Letter: Enumerable {}

 public protocol C: Letter {
     associatedtype CType: Letter
 }

 public protocol B: C where Self.CType == AType.CType {
     associatedtype AType: A
 }

 public protocol A: C {
     
     typealias BType = any B
     
     var b: BType { get }
     
 }

 extension A {
     
     public var compound: Compound {
         self.b.compound
     }
     
     public var rawValue: String {
         self.b.rawValue
     }
     
 }

 public enum Letters {
     
     public enum CType: Letter {
         case b1, b2
     }
     
     public protocol LettersB: B where AType == Letters.AType {}
     
     public enum B1: LettersB {
         case a, b, c
     }
     
     public enum B2: LettersB {
         case one, two, three
     }
     
     public enum AType: A {
         
         public static var allCases: [Self] {
             CType.cases.flatMap {
                 switch $0 {
                 case .b1: return B1.cases.map(AType.b1)
                 case .b2: return B2.cases.map(AType.b2)
                 }
             }
         }
         
         public typealias CType = Letters.CType
         
         case b1(B1)
         case b2(B2)
         
         public var b: BType {
             switch self {
             case .b1(let b1): return b1
             case .b2(let b2): return b2
             }
         }
     }
     
 }
 */
