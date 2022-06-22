import SwiftUI


func fibo(_ n: UInt) -> UInt {
    if n < 3 {
        return n
    }
    var pp: UInt = 1, p: UInt = 2
    
    for _ in 3...n {
        let tmp: UInt = p
        p = p + pp
        pp = tmp
    }
    
    return p
}


func fibonacci(_ n: UInt) async -> UInt  {
    if n < 3 {
        return n
    }
    return await fibonacci(n-1) + fibonacci(n-2)
}


Task() {
    print("fibo(30) = \(fibo(30))")
}


Task() {
    print("fibonacci(30) = \(await fibonacci(30)) - recursive")
}



