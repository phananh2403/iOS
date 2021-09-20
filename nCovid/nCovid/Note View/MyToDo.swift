//
//  MyToDo.swift
//  nCovid
//
//  Created by MACBOOK PRO on 18/09/2021.
//

import Foundation

class ToDoItem {
    var title: String
    var done: Bool
    
    public init(title: String)
    {
        self.title = title
        self.done = false
    }

}
extension ToDoItem{
    public class func getMockData() -> [ToDoItem]
    {
        return [
            ToDoItem(title: "abc"),
            ToDoItem(title: "xyz")
        ]
    }
}
