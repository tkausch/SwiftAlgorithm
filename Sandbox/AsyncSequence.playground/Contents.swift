import SwiftUI


extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

struct AsyncCountdown: AsyncSequence, AsyncIteratorProtocol {

    typealias AsyncIterator = AsyncCountdown
    typealias Element = Int
    
    var count: Int
    
    mutating func next() async throws -> Int? {
        try await Task.sleep(seconds: 2.0)
        if count == 0 {
            return nil
        } else {
            let currentCount = count
            count -= 1
            return currentCount
        }
    }

    func makeAsyncIterator() -> Self {
        return self
    }
    
    
}

var countDown3 = AsyncCountdown(count:3)
let countDown14 = AsyncCountdown(count:14)


let t3 = Task() { () -> () in
    for try await i in countDown3 {
        print(i)
    }
    print("t3 done")
}


let t14 = Task() { () -> () in
    for try await j in countDown14 {
        print(j)
    }
    print("t14 done")
}
