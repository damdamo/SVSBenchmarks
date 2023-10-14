import SVSKit
import Foundation

//func testERK() {
//  let parserPN = PnmlParser()
//  let (net1, marking1) = parserPN.loadPN(filePath: "model.pnml")
//  var s = Stopwatch()
//
//  let parserCTL = CTLParser()
//  let dicCTL = parserCTL.loadCTL(filePath: "ReachabilityFireability.xml")
//
//  s.reset()
//
////    var answers: [String: Bool] = [:]
//  var answers: [String: SVS] = [:]
//  var times: [String: String] = [:]
//  for (key, formula) in dicCTL.sorted(by: {$0.key < $1.key}) {
//    let ctlReduced = CTL(formula: formula, net: net1, canonicityLevel: .full, simplified: false, debug: false).queryReduction()
//    print("-------------------------------")
//    print(key)
//    s.reset()
////      answers[key] = ctlReduced.eval(marking: marking1)
//    answers[key] = ctlReduced.eval()
//    print(answers[key]!)
//    times[key] = s.elapsed.humanFormat
//    print(s.elapsed.humanFormat)
//    print("-------------------------------")
//  }
//
//  var svNumbers: [Int] = []
//  var markingNumbers: [Int] = []
////    var count = 0
//
//  for (key, b) in answers.sorted(by: {$0.key < $1.key}) {
////      print("Formula \(key) is: \(b) (\(times[key]!))")
//    print("Formula \(key) is: \(times[key]!)")
//    print("Nb of sv: \(answers[key]!.count)")
//    svNumbers.append(answers[key]!.count)
//    for sv in answers[key]! {
////        count += 1
//      markingNumbers.append(1 + sv.value.exc.count)
//    }
//  }
//
//  let avgMarking = Double(markingNumbers.reduce(0, {$0+$1})) / Double(markingNumbers.count)
//  let avgSV = Double(svNumbers.reduce(0, {$0+$1})) / Double(svNumbers.count)
//
//  print("Nb average SV: \(avgSV)")
//  print("Nb average marking: \(avgMarking)")
//  print("Std sv: \(standardDeviationInt(seq: svNumbers))")
//  print("Std marking: \(standardDeviationInt(seq: markingNumbers))")
//}

//func main() {
//
//  let arguments = CommandLine.arguments
//
//  let folderNames = getFolderNames().sorted()
//  print(folderNames)
//  let csvFilePath = directoryResources + "result.csv"
//
//  for folderName in folderNames {
//    print(folderName)
//    let pnmlPath = directoryResources + folderName + "/model.pnml"
//    let ctlPath = directoryResources + folderName + "/ReachabilityFireability.xml"
//    let parserPN = PnmlParser()
//    let (net, _) = parserPN.loadPN(filePath: pnmlPath)
//    print(net.places.count)
//    print(net.transitions.count)
//    let parserCTL = CTLParser()
//    let dicCTL = parserCTL.loadCTL(filePath: ctlPath)
//
//    var csvData: [[String]] = []
//    if arguments[2] == "0" {
//      let firstCell = "Name (nb places:" + net.places.count.description + "/ nb transitions:" + net.transitions.count.description + ")"
//      csvData.append([firstCell, "Time (sec)", "SV nb:"])
//      writeInFile(csvData: csvData, csvFilePath: csvFilePath)
//      csvData = []
//    }
//
////    csvData.append([folderName, "Place nb:", "Transition nb:"])
//
//
//    var timer = Stopwatch()
//
//    for (key, formula) in dicCTL.sorted(by: {$0.key < $1.key}) {
//      let ctlReduced = CTL(formula: formula, net: net, canonicityLevel: .full, simplified: false, debug: false).queryReduction()
//      timer.reset()
//      let r = ctlReduced.eval()
//      let t = timer.elapsed.humanFormat
//      if let svs = r {
//        csvData.append([key, t, svs.count.description])
//      } else {
//        csvData.append([key, "DNF"])
//      }
//    }
//    csvData.append([])
//    csvData.append([])
//    writeInFile(csvData: csvData, csvFilePath: csvFilePath)
//    csvData = []
//  }
//}

func main() {
  
  let arguments = CommandLine.arguments
  let folderName = arguments[1]
//  let folderNames = getFolderNames().sorted()
//  print(folderNames)
  let csvFilePath = directoryResources + "result.csv"

//  for folderName in folderNames {
//    print(folderName)
    let pnmlPath = directoryResources + folderName + "/model.pnml"
    let ctlPath = directoryResources + folderName + "/ReachabilityFireability.xml"
    let parserPN = PnmlParser()
    let (net, _) = parserPN.loadPN(filePath: pnmlPath)
    print(net.places.count)
    print(net.transitions.count)
    let parserCTL = CTLParser()
    let dicCTL = parserCTL.loadCTL(filePath: ctlPath)

//    var csvData: [[String]] = []
  if arguments[2] == "0" {
    let firstCell = "Name (nb places:" + net.places.count.description + "/ nb transitions:" + net.transitions.count.description + ")"
    writeInFile(csvData: [[firstCell, "Time (sec)", "SV nb:"],[]], csvFilePath: csvFilePath)
  }
  
  let (key, formula) = dicCTL.sorted(by: {$0.key < $1.key})[Int(arguments[2])!]
  writeInFile(csvData: [[key]], csvFilePath: csvFilePath)
  var timer = Stopwatch()
//
//    for (key, formula) in dicCTL.sorted(by: {$0.key < $1.key}) {
  let ctlReduced = CTL(formula: formula, net: net, canonicityLevel: .full, simplified: false, debug: false).queryReduction()
  timer.reset()
  let svs = ctlReduced.eval()
  let t = timer.elapsed.humanFormat
  
  let csvData = [["", t, svs.count.description],[]]
  writeInFile(csvData: csvData, csvFilePath: csvFilePath)
}

main()
