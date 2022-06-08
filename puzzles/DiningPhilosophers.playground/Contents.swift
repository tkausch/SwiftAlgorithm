import Cocoa

//
//
//  Copyright (C) 2021 Thomas Kausch.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
//  main.swift
//  SwiftConcurrency
//
//  Created by Thomas Kausch on 8.6.21.
//
//
// Layout of the table (P = philosopher, f = fork) for 4 Philosophers
//          P0
//       f3    f0
//     P3        P1
//       f2    f1
//          P2
//
//

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Int) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}


class Fork {
    let id: Int
    
    init(index: Int) {
        self.id = index
    }
}

class Philosopher {
    
    let id: Int
    let waiter: Waiter
    
    init(index: Int, waiter: Waiter) {
        self.id = index
        self.waiter = waiter
    }
    
    func yield(_ seconds: Int) async {
        do {
            try await Task.sleep(seconds: seconds)
        } catch { // do nothing
        }
    }
    
    func eatWith(forks: [Fork]) async {
        let time = Int.random(in: 1..<5)
        print("Philosopher \(id) is eating \(time) seconds")
        await yield(time)
        await waiter.restoreForks(forks)
    }
    
    func think() async {
        let time = Int.random(in: 1..<5)
        print("Philosopher \(id) is thinking \(time) seconds")
        await yield(time)
    }
    
    
    func run() {
        Task() {
            for _ in 0..<10 {
                await think()
                if  let forks = await waiter.askForksFor(philosopher: self) {
                    await eatWith(forks: forks)
                }
            }
        }
    }
}


actor Waiter {

    var forks = [Fork?]()
    
    lazy var forksCount = {
         forks.count
    }()
    
    init(nmbOfPhilosophers: Int) {
        var tmpForks = [Fork?]()
        for idx in 0..<nmbOfPhilosophers {
            tmpForks.append(Fork(index: idx))
        }
        self.forks = tmpForks
    }
    
    func askForksFor(philosopher: Philosopher) -> [Fork]? {
        let leftForkIdx = philosopher.id
        let rightForkIdx = (philosopher.id - 1 + forksCount) % forksCount
        
        if let leftFork = forks[leftForkIdx], let rightFork = forks[rightForkIdx] {
            return [leftFork, rightFork]
        }
        return nil
    }
    
    func restoreForks(_ returnedForks: [Fork]) {
        for fork in returnedForks {
            self.forks[fork.id] = fork
        }
    }

}


let max = 4

var waiter = Waiter(nmbOfPhilosophers: max)

for i in 0..<max {
    let philosopher = Philosopher(index: i, waiter: waiter)
    philosopher.run()
}
