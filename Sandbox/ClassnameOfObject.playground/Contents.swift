import UIKit

//
// This is the playground related with my post:
// 
//

class C {}
struct S {}
protocol P {}
enum E: Int {
   case a
   case b
}
func F() {}

print(C.Type.self)    // C.Type
print(S.Type.self)    // S.Type
print(P.Type.self)    // P.Type.Protocol
print(E.Type.self)    // E.Type


print(type(of:S()))   // S
print(type(of:C()))   // C
print(type(of:E.a))   // E
print(type(of:F))     // () -> ()


S.self == type(of:S()) // true
C.self == type(of:C()) // true
E.self == type(of:E.a) // true
