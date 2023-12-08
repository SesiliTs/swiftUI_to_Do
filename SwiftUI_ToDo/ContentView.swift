//
//  ContentView.swift
//  SwiftUI_ToDo
//
//  Created by Sesili Tsikaridze on 08.12.23.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    let title: String
    let date: String
    var isCompleted: Bool
}

struct ContentView: View {
    
    private let gradientColor = LinearGradient(colors: [.gradientFirst, .gradientSecond], startPoint: .leading, endPoint: .trailing)
    
    @State private var tasksToComplete = 6
    @State private var completedTasksNumber = 0
    
    @State private var allTasks = [
        Task(title: "Mobile App Research", date: "4 Oct", isCompleted: false),
        Task(title: "Prepare Wireframe for Main Flow", date: "4 Oct", isCompleted: false),
        Task(title: "Prepare Screens", date: "4 Oct", isCompleted: false),
        Task(title: "Website Research", date: "5 Oct", isCompleted: false),
        Task(title: "Prepare Wireframe for Main Flow", date: "5 Oct", isCompleted: false),
        Task(title: "Prepare Screens", date: "5 Oct", isCompleted: false)
        
    ]
    
    @State private var completedTasks = [Task]()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    
                    Text("""
                     You have \(tasksToComplete) tasks
                     to complete
                     """)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.white)
                    Spacer()
                    Image("ProfileImage")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.orange)
                                .position(x: 40, y: 40)
                                .overlay(
                                    Text("\(completedTasksNumber)")
                                        .font(.system(size: 9))
                                        .foregroundColor(.white)
                                        .position(x: 40, y: 40)
                                )
                        )
                }
                
                Button("Complete All") {
                    completeAllTasks()
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(gradientColor)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .cornerRadius(8)
                
                Text("Completed Tasks")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                
                ScrollView {
                    Section()
                    {
                        ForEach(completedTasks) { task in
                            HStack(spacing: 14) {
                                Rectangle()
                                    .fill(gradientColor)
                                    .frame(width: 15)
                                VStack (alignment: .leading, spacing: 5) {
                                    Text(task.title)
                                        .font(.system(size: 16))
                                    HStack (spacing: 7) {
                                        Image("CalendarIcon")
                                            .frame(width: 15, height: 16)
                                        Text(task.date)
                                            .font(.system(size: 14, weight: .light))
                                    }
                                    
                                }
                                Spacer()
                                Button(action: {
                                    toggleTaskFalse(task: task)
                                    completedTasksNumber = completedTasks.count
                                    tasksToComplete = allTasks.count
                                }) {
                                    
                                    Image(task.isCompleted == true ? "CheckmarkFilled" : "CheckmarkEmpty")
                                        .padding(.trailing, 11)
                                }
                            }
                            .frame(height: 80)
                            .background(.appDarkGrey)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                    Section(header: HStack {
                        Text("To Do")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }) {
                        
                        ForEach(allTasks) { task in
                            HStack(spacing: 14) {
                                Rectangle()
                                    .fill(gradientColor)
                                    .frame(width: 15)
                                VStack (alignment: .leading, spacing: 5) {
                                    Text(task.title)
                                        .font(.system(size: 16))
                                    HStack (spacing: 7) {
                                        Image("CalendarIcon")
                                            .frame(width: 15, height: 16)
                                        Text(task.date)
                                            .font(.system(size: 14, weight: .light))
                                    }
                                    
                                }
                                Spacer()
                                Button(action: {
                                    toggleTaskCompletion(task: task)
                                    completedTasksNumber = completedTasks.count
                                    tasksToComplete = allTasks.count
                                }) {
                                    
                                    Image(task.isCompleted == true ? "CheckmarkFilled" : "CheckmarkEmpty")
                                        .padding(.trailing, 11)
                                }
                            }
                            .frame(height: 80)
                            .background(.appDarkGrey)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .colorScheme(.dark)
                .padding(.vertical, 10)
                
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func toggleTaskCompletion(task: Task) {
        if let index = allTasks.firstIndex(where: { $0.id == task.id }) {
            allTasks[index].isCompleted.toggle()
            
            if allTasks[index].isCompleted {
                completedTasks.append(allTasks.remove(at: index))
            }
        }
    }
    
    private func toggleTaskFalse(task: Task) {
        if let index = completedTasks.firstIndex(where: { $0.id == task.id }) {
            completedTasks[index].isCompleted.toggle()
            
            if completedTasks[index].isCompleted == false {
                allTasks.append(completedTasks.remove(at: index))
            }
        }
    }
    
    private func completeAllTasks() {
        for index in allTasks.indices {
            allTasks[index].isCompleted = true
            completedTasks.append(allTasks[index])
        }
        allTasks.removeAll()
        tasksToComplete = 0
        completedTasksNumber = completedTasks.count
    }

}

#Preview {
    ContentView()
}


