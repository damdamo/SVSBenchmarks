import SVSKit
import Foundation

func main() {
  
  let arguments = CommandLine.arguments
  let folderName = arguments[1]
  let csvFilePath = directoryResources + "result.csv"

  let pnmlPath = directoryResources + folderName + "/model.pnml"
  let ctlPath = directoryResources + folderName + "/ReachabilityFireability.xml"
  let parserPN = PnmlParser()
  let (net, _) = parserPN.loadPN(filePath: pnmlPath)
  print(net.places.count)
  print(net.transitions.count)
  let parserCTL = CTLParser()
  let dicCTL = parserCTL.loadCTL(filePath: ctlPath)

  if arguments[2] == "0" {
    let firstCell = "Name (nb places:" + net.places.count.description + "/ nb transitions:" + net.transitions.count.description + ")"
    writeInFile(csvData: [[firstCell, "Time (sec)", "SV nb:"],[]], csvFilePath: csvFilePath)
  }
  
  let (key, formula) = dicCTL.sorted(by: {$0.key < $1.key})[Int(arguments[2])!]
  writeInFile(csvData: [[key]], csvFilePath: csvFilePath)
  var timer = Stopwatch()

  let ctlReduced = CTL(formula: formula, net: net, canonicityLevel: .full, simplified: false, debug: false).queryReduction()
  timer.reset()
  let svs = ctlReduced.eval()
  let t = timer.elapsed.humanFormat
  
  let csvData = [["", t, svs.count.description],[]]
  writeInFile(csvData: csvData, csvFilePath: csvFilePath)
}

main()
