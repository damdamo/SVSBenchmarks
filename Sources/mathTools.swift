import SVSKit
import Foundation

func standardDeviationUInt64(seq:[UInt64]) -> Double {
  
  var listDouble: [Double] = []
  for v in seq {
    listDouble.append(Stopwatch.TimeInterval(ns: v).toMs)
  }
        
  let size: Double = Double(seq.count)
  var sum = 0.0
  var SD = 0.0
  var S = 0.0
  var resultSD = 0.0

  // Calculating the mean
  for x in 0 ..< Int(size) {
    sum += listDouble[x]
  }
  let meanValue = sum/size

  // Calculating standard deviation
  for y in 0 ..< Int(size) {
    SD += pow(Double(listDouble[y] - meanValue), 2)
  }
  S = SD/Double(size)
  resultSD = sqrt(S)
  
  return Double(resultSD)
}

func standardDeviationInt(seq:[Int]) -> Double {
   let size = seq.count
   var sum = 0
   var SD = 0.0
   var S = 0.0
   var resultSD = 0.0
   
   // Calculating the mean
   for x in 0..<size{
      sum += seq[x]
   }
   let meanValue = sum/size
   
   // Calculating standard deviation
   for y in 0..<size{
      SD += pow(Double(seq[y] - meanValue), 2)
   }
   S = SD/Double(size)
   resultSD = sqrt(S)
   
   return resultSD
}
