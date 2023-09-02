//
//  Levenshtein.swift
//  Marla
//
//  Created from https://gist.github.com/RuiCarneiro/82bf91214e3e09222233b1fc04139c86 on 07/05/2019.
//

import Foundation

extension String {
  subscript(index: Int) -> Character {
    self[self.index(self.startIndex, offsetBy: index)]
  }
}

extension String {
  func levenshtein(_ other: String) -> Int {
    let sCount = self.count
    let oCount = other.count
    guard sCount != 0 else {
      return oCount
    }
    guard oCount != 0 else {
      return sCount
    }

    let line: [Int]  = Array(repeating: 0, count: oCount + 1)
    var mat: [[Int]] = Array(repeating: line, count: sCount + 1)
    for index in 0...sCount {
      mat[index][0] = index
    }
    for jindex in 0...oCount {
      mat[0][jindex] = jindex
    }
    for jindex in 1...oCount {
      for index in 1...sCount {
        if self[index - 1] == other[jindex - 1] {
          mat[index][jindex] = mat[index - 1][jindex - 1]       // no operation
        } else {
          let del = mat[index - 1][jindex] + 1         // deletion
          let ins = mat[index][jindex - 1] + 1         // insertion
          let sub = mat[index - 1][jindex - 1] + 1     // substitution
          mat[index][jindex] = min(min(del, ins), sub)
        }
      }
    }
    return mat[sCount][oCount]
  }
}

// Access older versions (Swift 3.x) in history
// Usage:
// "abc".levenshtein("abd")
