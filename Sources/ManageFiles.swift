import Foundation

let directoryResources = "/Users/damienmorard/Developer/Github/SVSBenchmarks/Sources/Resources/"

func collectFilesFromResources() -> [String] {
  
  let resourcesDirectory = "/Users/damienmorard/Developer/Github/SVSBenchmarks/Sources/Resources"
  
  do {
    let folderURL = try FileManager.default.contentsOfDirectory(atPath: resourcesDirectory)
    
    // Extract just the file names
    let folderNames = folderURL.map { URL(fileURLWithPath: $0).lastPathComponent }
    
    // Print the file names
    for folder in folderNames {
      let dir = "/Users/damienmorard/Developer/Github/SVSBenchmarks/Sources/Resources" + "/\(folder)/"
      let contentURL = try FileManager.default.contentsOfDirectory(atPath: dir)
      let contentFileNames = contentURL.map { URL(fileURLWithPath: $0).lastPathComponent }
      for file in contentFileNames {
        print(file)
      }
    }
  } catch {
    print("Error while enumerating files: \(error.localizedDescription)")
  }
 
  return []
}

func getFolderNames() -> [String] {
  // Specify the file path
  let filePath =  directoryResources + "lookAt.txt"
  var result: [String] = []

  // Initialize a file handle
  if let fileHandle = FileHandle(forReadingAtPath: filePath) {
    defer {
      fileHandle.closeFile()
    }
      
    // Read the file line by line
    var offset: UInt64 = 0
    var lineData = Data()
    
    while true {
      let data = fileHandle.readData(ofLength: 1)
      if data.isEmpty {
        // End of file
//        if !lineData.isEmpty {
//          if let line = String(data: lineData, encoding: .utf8) {
//            print("Line: \(line)")
//          }
//        }
        break
      }
      
      if data == "\n".data(using: .utf8) {
        if !lineData.isEmpty {
          if let line = String(data: lineData, encoding: .utf8) {
            result.append(line)
          }
          lineData.removeAll()
        }
      } else {
        lineData.append(data)
      }
      offset += 1
    }
  }
  return result
}
