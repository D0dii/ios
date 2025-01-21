import SwiftUI
import Charts  // For the bar chart

struct StatisticsView: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Completed Tasks: \(completedTasksCount())")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Divider()
                
                Text("Priority Distribution")
                    .font(.title2)
                    .fontWeight(.bold)
                
                if #available(iOS 16.0, *) {
                    priorityChart()
                        .padding(.top, 10)
                } else {
                    Text("Priority Distribution by Count (Low, Medium, High)")
                        .font(.body)
                        .padding(.vertical, 6)
                    Text("Low: \(priorityCount("Low"))")
                    Text("Medium: \(priorityCount("Medium"))")
                    Text("High: \(priorityCount("High"))")
                        .padding(.bottom, 20)
                }
                
                Text("All Tasks per Day")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                if #available(iOS 16.0, *) {
                    allTasksChart()
                        .padding(.top, 10)
                } else {
                    Text("All tasks count per day is only available on iOS 16.0 or later.")
                        .font(.body)
                        .padding(.top, 10)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Statistics")
    }
    
    private func completedTasksCount() -> Int {
        modelData.todos.filter { $0.isCompleted }.count
    }
    
    private func priorityCount(_ priority: String) -> Int {
        modelData.todos.filter { $0.priority == priority && $0.isCompleted }.count
    }
    
    @available(iOS 16.0, *)
    private func priorityChart() -> some View {
        Chart {
            BarMark(
                x: .value("Priority", "Low"),
                y: .value("Count", priorityCount("Low"))
            )
            .foregroundStyle(.blue)
            
            BarMark(
                x: .value("Priority", "Medium"),
                y: .value("Count", priorityCount("Medium"))
            )
            .foregroundStyle(.yellow)
            
            BarMark(
                x: .value("Priority", "High"),
                y: .value("Count", priorityCount("High"))
            )
            .foregroundStyle(.red)
        }
        .frame(height: 180)
        .padding(.top, 20)
    }
    
    @available(iOS 16.0, *)
    private func allTasksChart() -> some View {
        Chart {
            ForEach(allTasksPerDay(), id: \.date) { taskDate in
                BarMark(
                    x: .value("Date", taskDate.date, unit: .day),
                    y: .value("Total Tasks", taskDate.count)
                )
                .foregroundStyle(.purple)
            }
        }
        .frame(height: 180)
        .padding(.top, 10)
    }
    

    private func allTasksPerDay() -> [DateCount] {

        let allTasks = modelData.todos
        var taskCountByDate: [String: Int] = [:]
        
        for todo in allTasks {
            let dateString = formattedDate(todo.deadline)
            taskCountByDate[dateString, default: 0] += 1
        }
        
        let dateCounts = taskCountByDate.map { DateCount(date: date(from: $0.key), count: $0.value) }
        return dateCounts.sorted { $0.date < $1.date }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func date(from string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string) ?? Date()
    }
}

struct DateCount {
    var date: Date
    var count: Int
}
