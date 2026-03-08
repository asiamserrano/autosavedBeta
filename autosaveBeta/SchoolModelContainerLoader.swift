//
//  SchoolModelContainerLoader.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/7/26.
//

import Foundation
import Core
import SwiftData
import SwiftUI

public class FinalPersonGroup<T: FinalPersonProtocol> {
    
    var set: Set<T>
    
    init() {
        self.set = .defaultValue
    }
    
    func add(_ t: T) -> FinalPersonGroup {
        self.insert(t)
        return self
    }
    
    func insert(_ t: T?) -> Void {
        if let t = t {
            self.set.insert(t)
        }
    }
    
    func insert(_ s: FinalPersonGroup) -> Void {
        s.set.forEach {
            self.insert($0)
        }
    }
    
    func random() -> T? {
        if count > 0, let element = set.randomElement() {
            return element
        } else { return nil }
    }
    
    func forEach(_ action: @escaping (T) -> Void) -> Void {
        self.set.forEach(action)
    }
    
    var count: Int { self.set.count }
    var array: [T] { .init(set) }
    
    func matrix(_ sizes: [Int]) -> [[T]] {
        var subs: [[T]] = .defaultValue
        var prev: Int = 0
        var curr: Int
        for index in 0..<sizes.count {
            let size = sizes[index]
            curr = prev+size
            let result: [T] = array[prev..<curr].toArray
            prev = curr
            subs.append(result)
        }
        return subs
    }
    
}

public class SchoolModelContainerLoader {
    
    private static let BUS_SIZE: Int = 48
            
    private typealias Students = FinalPersonGroup<Student>
    private typealias Teachers = FinalPersonGroup<Teacher>
    private typealias Drivers = FinalPersonGroup<BusDriver>
    
    public static func load(_ container: ModelContainer) -> ModelContainer {
        let names: RandomizedArray = .init(loadFileAsStrings(filePath: NAMES_FILE_PATH))
        
        let maxBusSize = 48;
        let minBusSize = 20;
        let numOfGrades = Grades.cases.count;
        
        var studentGrades: [Grades: Students] = [:]
        var teacherGrades: [Grades: Teachers] = [:]
        
        Neighborhood.cases.forEach { neighborhood in
            
            let numOfBuses = Int.random(in: 1..<5)// Number of elements
            let minNumOfStudents = numOfBuses * minBusSize;
            let maxNumOfStudents = (numOfBuses * maxBusSize) + 1;
            let numOfStudents = Int.random(in: minNumOfStudents..<maxNumOfStudents); // Target sum
            
            let busDist = generateRandomNumbers(numOfStudents, numOfBuses, minBusSize, maxBusSize, "buses");
            let gradeDist = generateRandomNumbers(numOfStudents, numOfGrades, 1, numOfStudents - 2, "students");
     
            let students: Students = .init()
            for index in 0..<studentGrades.count {
                let grade = Grades.cases[index]
                let count = gradeDist[index]
                count.forEach {
                    let info = Info(name: names.get())
                    let student = Student(info: info, grade: grade, neighborhood: neighborhood)
                    container.insert(student)
                    students.insert(student)
                    
                    let value = studentGrades[grade] ?? .init()
                    studentGrades[grade] = value.add(student)
                    
                }
            }
            
            let studentMatrix = students.matrix(busDist)
            
            let drivers: Drivers = .init()
            for index in 0..<busDist.count {
                let count = busDist[index]
                count.forEach {
                    let info = Info(name: names.get())
                    let driver = BusDriver(info: info, neighborhood: neighborhood)
                    container.insert(driver)
                    drivers.insert(driver)
                    studentMatrix[index].forEach { $0.setBusDriver(driver) }
                }
            }
            
        }
        
        let teachers: Teachers = .init()
        Grades.cases.forEach { grade in
            Subjects.cases.forEach { subject in
                let index = Int.random(in: 3...5)
                index.forEach {
                    let info = Info(name: names.get())
                    let teacher = Teacher(info: info, subject: subject, grade: grade)
                    container.insert(teacher)
                    teachers.insert(teacher)
                    let value = teacherGrades[grade] ?? .init()
                    teacherGrades[grade] = value.add(teacher)
                }
            }
        }
        
        
        
        
        
//        let count: Int = names.count
        
//            let students: Students = .init()
//            Grades.cases.forEach { grade in
//                Neighborhood.cases.forEach { neighborhood in
//
//                }
////                let index = Int.random(in: 16...20)
////                index.forEach {
////                    let info = Info(name: names.get())
////                    let student = Student(info: info, grade: grade)
////                    students.insert(student)
////                }
//            }
//
//            let teachers: Teachers = .init()
//            Grades.cases.forEach { grade in
//                Subjects.cases.forEach { subject in
//                    let index = Int.random(in: 3...5)
//                    index.forEach {
//                        let info = Info(name: names.get())
//                        let teacher = Teacher(info: info, subject: subject, grade: grade)
//                        teachers.insert(teacher)
//                    }
//                }
//            }

//            let drivers: Drivers = .init()
//            Neighborhood.cases.forEach { neighborhood in
//                let index = Int.random(in: 2...4)
//                index.forEach {
//                    let info = Info(name: names.get())
//                    let driver = BusDriver(info: info, shift: shift)
//                    drivers.insert(driver)
//                }
//            }
//            Shifts.cases.forEach { shift in
//
//            }
//
//            students.forEach { student in
//                Grades.cases.forEach { grade in
//                    Subjects.cases.forEach { subject in
//
//                    }
//                }
//            }
        
        return container
    }

    private static func generateRandomNumbers(_ n: Int, _ count: Int, _ m: Int, _ k: Int, _ seed: String) -> [Int] {

          let min = count * m;
          let max = count * k;

          let nTooSmall = n < min;
          let nTooBig = n > max;

          // Check if the target sum is feasible
          if (nTooSmall || nTooBig) {
              print("    minAllowed: \(m)")
              print("    maxAllowed: \(k)")
              var s: String;
              if (nTooSmall) { s = "       min sum '\(min)' is bigger than '\(n)'" }
              else  { s = "       max sum '\(max)' is smaller than '\(n)'" }
              print("\(s) for \(seed)");
              return .defaultValue;
          }

        var numbers: [Int] = .defaultValue
          var remainingSum = n;
          var remainingCount = count;
        
        (count - 1).forEach {
            // Calculate the minimum and maximum possible values for the current number
            let currentMin: Int = Swift.max(m, remainingSum - (remainingCount - 1) * k);
            let currentMax = Swift.min(k, remainingSum - (remainingCount - 1) * m);

            // Generate a random number within the adjusted range [currentMin, currentMax]
            // Formula: rand.nextInt(max - min + 1) + min
            let randomNum = Int.random(in: 0..<currentMax - currentMin + 1) + currentMin

            numbers.append(randomNum)
            remainingSum = remainingSum - randomNum
            remainingCount = remainingCount - 1
        }
        
          // The last number is determined by the remaining sum to ensure the total sum is n
          numbers.append(remainingSum);

          return numbers;
      }
    
    private static func generateRandomNumbers(_ n: Int, _ S: Int, _ M: Int) -> [Int] {
        // Condition check: The minimum possible sum must be less than or equal to S.
        if (S <= n * (M + 1) - 1) {
            print("Target sum S is too low for the given n and M constraints.")
            return .defaultValue
        }
        
        var points: [Int] = .defaultValue
        let S_prime = S - n * (M + 1); // Adjust sum for the minimum value
        
        // 1. Generate n-1 distinct random points in the range [0, S_prime]
        for i in 0..<n-1 {
            points.append(Int.random(in: 0..<S_prime + 1));
        }
        
        // Add 0 and S_prime as boundary points
        points.append(0);
        points.append(S_prime);
        
        // 2. Sort the points
        points = points.sorted()
        
        var result: [Int] = .defaultValue
        // 3. Calculate differences and add minimum value
        for i in 0..<n {
            let difference = points[i + 1] - points[i];
            result.append(difference + (M + 1)) // Add the minimum value offset
        }
        
        return result;
    }
    
//    private static func getNumbersForNeighborhood(_ n: Neighborhood) -> String {
//        
//        let neighborhood = n.rawValue
//        print("neighborhood: \(neighborhood)");
//        let maxBusSize = 48;
//        let minBusSize = 20;
//        let numOfGrades = Grades.cases.count;
//        
//        let numOfBuses = Int.random(in: 1..<5)// Number of elements
//        print("# of buses for neighborhood: \(numOfBuses)");
//        let minNumOfStudents = numOfBuses * minBusSize;
//        print("min # of students: \(minNumOfStudents)");
//        let maxNumOfStudents = (numOfBuses * maxBusSize) + 1;
//        print("max # of students: \(maxNumOfStudents)");
//        let numOfStudents = Int.random(in: minNumOfStudents..<maxNumOfStudents); // Target sum
//        print("total # of students in neighborhood: \(numOfStudents)");
//        
//        let busDist = generateRandomNumbers(numOfStudents, numOfBuses, minBusSize, maxBusSize, "buses");
//        let gradeDist = generateRandomNumbers(numOfStudents, numOfGrades, 1, numOfStudents - 2, "students");
//        
//        print("Students on each bus: \(busDist)");
//        print("Students in each grade: \(gradeDist)");
//        print("\n_______________________________\n");
//        return neighborhood
//    }
    
    private static func getNumbersForNeighborhood(_ n: Neighborhood) -> [Int] {
        
        let neighborhood = n.rawValue
        print("neighborhood: \(neighborhood)");
        let maxBusSize = 48;
        let minBusSize = 20;
        let numOfGrades = Grades.cases.count;
        
        let numOfBuses = Int.random(in: 1..<5)// Number of elements
        print("# of buses for neighborhood: \(numOfBuses)");
        let minNumOfStudents = numOfBuses * minBusSize;
        print("min # of students: \(minNumOfStudents)");
        let maxNumOfStudents = (numOfBuses * maxBusSize) + 1;
        print("max # of students: \(maxNumOfStudents)");
        let numOfStudents = Int.random(in: minNumOfStudents..<maxNumOfStudents); // Target sum
        print("total # of students in neighborhood: \(numOfStudents)");
        
        let busDist = generateRandomNumbers(numOfStudents, numOfBuses, minBusSize, maxBusSize, "buses");
        let gradeDist = generateRandomNumbers(numOfStudents, numOfGrades, 1, numOfStudents - 2, "students");
        
        print("Students on each bus: \(busDist)");
        print("Students in each grade: \(gradeDist)");
        
        return gradeDist
    }
    
    private static func getNumbersForTeachers(_ grades: [Grades: Int]) -> Void {
        /*
         Students in 9th grade: 239
         Students in 11th grade: 102
         Students in 12th grade: 65
         Students in 10th grade: 88
         */
        
        Subjects.cases.forEach { subject in
            print("subject: \(subject.rawValue)");
            grades.forEach { grade, numOfStudents in
                print("grade: \(grade.rawValue)");
                print("numOfStudents: \(numOfStudents)");
                let numOfTeachers = Int.random(in: 3...5)// Number of elements
                print("# of teachers: \(numOfTeachers)");
                let result = generateRandomNumbers(numOfStudents, numOfTeachers, 15)
                print("# of students per teacher: \(result)");
            }
        }
    }
    
    public static func getNumbersForNeighborhoods() -> [String] {
        
        var grades: [Grades: Int] = [:]
        
        let result: [String] = Neighborhood.cases.map { neighborhood in
            let gradesCount = getNumbersForNeighborhood(neighborhood)
            for index in 0..<Grades.cases.count {
                let grade = Grades.cases[index]
                let count = gradesCount[index]
                let value = grades[grade] ?? .zero
                grades[grade] = value + count
            }
            return neighborhood.rawValue
        }
        
        print("\n_______________________________\n");
        getNumbersForTeachers(grades)
        print("\n_______________________________\n");
        
        return result
    }
    
}

extension ArraySlice {
    
    var toArray: Array<Element> {
        .init(self)
    }
    
}

struct SchoolModelContainerLoaderView: View {
    
    var body: some View {
        Section("Neighborhoods") {
            ForEach(SchoolModelContainerLoader.getNumbersForNeighborhoods(), id:\.self) {
                Text($0)
            }
        }
    }
    
}

#Preview {
    
    Previewer { SchoolModelContainerLoaderView() }
    
}
