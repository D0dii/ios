//
//  Todo.swift
//  todo-app
//
//  Created by stud on 05/11/2024.
//
import SwiftData
import Foundation


@Model
class Todo: Identifiable, Codable{
    var id = UUID()
    var title: String
    var desc: String
    var priority: String
    var deadline: Date
    var longitude: Float
    var latitude: Float
    var isCompleted: Bool = false
    
    init(id: UUID = UUID(), title: String, desc: String, priority: String, deadline: Date, longitude: Float, latitude: Float, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.desc = desc
        self.priority = priority
        self.deadline = deadline
        self.longitude = longitude
        self.latitude = latitude
        self.isCompleted = isCompleted
    }
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            desc = try container.decode(String.self, forKey: .desc)
            priority = try container.decode(String.self, forKey: .priority)
            deadline = try container.decode(Date.self, forKey: .deadline)
            longitude = try container.decode(Float.self, forKey: .longitude)
            latitude = try container.decode(Float.self, forKey: .latitude)
            isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(desc, forKey: .desc)
            try container.encode(priority, forKey: .priority)
            try container.encode(deadline, forKey: .deadline)
            try container.encode(longitude, forKey: .longitude)
            try container.encode(latitude, forKey: .latitude)
            try container.encode(isCompleted, forKey: .isCompleted)
        }
        
        enum CodingKeys: String, CodingKey {
            case id, title, desc, priority, deadline, longitude, latitude, isCompleted
        }
}
