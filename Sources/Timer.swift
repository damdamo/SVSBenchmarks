import Foundation
import SVSKit

//func evalWithTimer(key: String, ctl: CTL) -> SVS? {
//
//  var res: SVS? = nil
//  // Create a semaphore
//  let semaphore = DispatchSemaphore(value: 0)
//
//  // Define the time limit in seconds
//  let timeLimit: DispatchTime = .now() + 1 // 1 seconds
//
//  // Define the task you want to run (replace this with your actual task)
//  let task = {
//    // Simulate a long-running task
//    //    sleep(5)
//    //    print("Task completed")
////    res = ctl.eval()
//    while true {
//      print(key)
//    }
//    semaphore.signal() // Signal that the task is done
//  }
//
//  // Execute the task asynchronously
//  DispatchQueue.global().async(execute: task)
//
//  // Wait for the task to complete or time out
//  let result = semaphore.wait(timeout: timeLimit)
//
//  if result == .timedOut {
//    // Task did not complete within the time limit, you can cancel it if needed
//    print("CTL evaluation timed out and was canceled")
//    return res
//  } else {
//    // Task completed within the time limit
//    print("CTL evaluation completed within the time limit")
//    return res
//  }
//
//}


//func evalWithTimer(key: String, ctl: CTL) -> SVS? {
//  var res: SVS?
//
//  // Create a semaphore
//  let semaphore = DispatchSemaphore(value: 0)
//
//  // Create a work item for your task
//  let workItem = DispatchWorkItem {
//    print(key)
//    res = ctl.eval()
////      sleep(10)
//    semaphore.signal() // Signal that the task is done
//  }
//
//  // Create a DispatchQueue
//  let queue = DispatchQueue.global()
//
//  // Execute the task asynchronously
//  queue.async(execute: workItem)
//
//  // Define the time limit in seconds
//  let timeLimit: DispatchTime = .now() + 1 // Adjust the time limit as needed
//
//  // Wait for the task to complete or time out
//  let result = semaphore.wait(timeout: timeLimit)
//
//  // Check if the task has timed out
//  if result == .timedOut {
//      print("CTL evaluation timed out and was canceled")
//      // Cancel the task if it's still running
//      workItem.cancel()
//      return res
//  } else {
//      // Task completed within the time limit
//      print("CTL evaluation completed within the time limit")
//      return res
//  }
//}



//// Define a function that performs your task
//func performTask(_ taskNumber: Int) {
//    print("Task \(taskNumber) started.")
//
//    // Simulate a long-running task (replace this with your actual task)
//    sleep(UInt32(taskNumber)) // Sleep for taskNumber seconds
//
//    print("Task \(taskNumber) completed.")
//}
//
//// Define the number of tasks
//let numberOfTasks = 5
//
//// Define the maximum execution time for each task in seconds
//let taskTimeout = 3
//
//// Create a dispatch group to wait for tasks
//let group = DispatchGroup()
//
//for taskNumber in 1...numberOfTasks {
//    group.enter()
//
//    // Execute the task asynchronously in a background queue
//    DispatchQueue.global().async {
//        performTask(taskNumber)
//        group.leave()
//    }
//
//    // Wait for the task to complete or time out
//    let result = group.wait(timeout: .now() + .seconds(taskTimeout))
//
//    if result == .timedOut {
//        // Task took too long, cancel it
//        print("Task \(taskNumber) timed out and was canceled.")
//    }
//}
//
//// Notify when all tasks are done
//group.notify(queue: .main) {
//    print("All tasks completed.")
//}
//
//// Main thread can continue to execute other tasks

// cancel the fetch after 2 seconds



//func fetchThingWithTimeout(key: String, ctl: CTL) async throws -> SVS {
//    let fetchTask = Task {
//      try await fetchThing(ctl: ctl)                           // start fetch
//    }
//
//    let timeoutTask = Task {
//        try await Task.sleep(for: .seconds(1))                // timeout in 2 seconds
//        fetchTask.cancel()
//    }
//
//    return try await withTaskCancellationHandler {            // handle cancelation by caller of `fetchThingWithTimeout`
//      print(key)
//        let result = try await fetchTask.value
//        timeoutTask.cancel()
//
//        return result
//    } onCancel: {
//        fetchTask.cancel()
//        timeoutTask.cancel()
//    }
//}
//
//// here is a random mockup that will take between 1 and 3 seconds to finish
//
//func fetchThing(ctl: CTL) async throws -> SVS {
////    let duration: TimeInterval = .random(in: 1...3)
////    try await Task.sleep(for: .seconds(duration))
////  return ctl.eval()
////  try await Task.sleep(for: .seconds(5))
//  try await Task.init(operation: ctl.eval)
//  return []
//}

//func evalWithTimer(key: String, ctl: CTL, timeLimitInSeconds: Double) -> SVS? {
//
//  var res: SVS? = nil
//  // Create a semaphore
//  let semaphore = DispatchSemaphore(value: 0)
//
//  // Define the time limit in seconds
//  let timeLimit: DispatchTime = .now() + timeLimitInSeconds
//
//  // Define the task you want to run (replace this with your actual task)
//  let task = {
//    res = ctl.eval()
//    semaphore.signal() // Signal that the task is done
//  }
//
//  // Execute the task asynchronously
//  let queue = DispatchQueue.global()
//
//  queue.async(execute: task)
//
//  // Wait for the task to complete or time out
//  let result = semaphore.wait(timeout: timeLimit)
//
//  if result == .timedOut {
//    // Task did not complete within the time limit, you can cancel it if needed
//    queue.async {
//      // Add code here to cancel the task if possible
//      // For example, you can use a cancellation mechanism within your 'somethingToExecute' object
//    }
//    print("Task evaluation timed out and was canceled")
//    return res
//  } else {
//    // Task completed within the time limit
//    print("Task evaluation completed within the time limit")
//    return res
//  }
//}

func evalWithTimer(key: String, ctl: CTL) -> SVS? {

  var res: SVS? = nil
  // Create a semaphore
//  let semaphore = DispatchSemaphore(value: 0)

  // Define the time limit in seconds

  // Define the task you want to run (replace this with your actual task)
  let task = {
    res = ctl.eval()
  }

  let t: DispatchWorkItem = DispatchWorkItem(block: task)
  

//  DispatchQueue.global().async(execute: t)
  

  // Execute the task asynchronously
//  DispatchQueue.global().async(execute: task)
  

  // Wait for the task to complete or time out
//  let result = semaphore.wait(timeout: timeLimit)

  let timeLimit: DispatchTime = .now() + 1 // 1 seconds
  let r = t.wait(timeout: timeLimit)
  
  switch r {
  case .success:
    print("YOUHOU")
  case .timedOut:
    print("NOOOOOO")
  }
  
//  if result == .timedOut {
//    // Task did not complete within the time limit, you can cancel it if needed
//    print("CTL evaluation timed out and was canceled")
//    return res
//  } else {
//    // Task completed within the time limit
//    print("CTL evaluation completed within the time limit")
//    return res
//  }

  return res
}
