//
//  main.swift
//  ModernApiDesignSamples
//
//  Created by YZ on 27.04.2023.
//

import Foundation

enum TextStyle{
    case Title
    case Body
}

protocol NoteItem {
    var value: String { get set }
}

struct Text: NoteItem{
    private var _value: String = String()
    
    var value : String {
        get {
            return self._value
        }
        set {
            self._value = newValue
        }
    }
    
    private(set) var textStyle: TextStyle

    init(_ value: String, _ textStyle: TextStyle = TextStyle.Body) {
        self.textStyle = textStyle
        self.value = value
    }
}

class Note{
    var items: [NoteItem] = []

    init(@NoteItemBuilder _ content: () -> [NoteItem]) {
        content().forEach { item in
            if let newItem = item as? Text {
                if newItem.textStyle == TextStyle.Title {
                    var newText = Text(newItem.value.uppercased(), newItem.textStyle)
                    items.append(newText)
                }else {
                    items.append(newItem)
                }
            }else {
                items.append(item)
            }
        }
    }
}

@resultBuilder
struct NoteItemBuilder{
    static func buildBlock(_ components: NoteItem...) -> [NoteItem] {
        return components
    }
}

@resultBuilder
struct NoteBuilder{
    static func buildBlock(_ components: Note...) -> [Note] {
        return components
    }
}

@NoteBuilder var notes: [Note] {
    Note (){
        Text("title1", TextStyle.Title)
        Text("note1", TextStyle.Body)
    }
    Note() {
        Text("note2")
    }
}

notes.forEach { note in
    note.items.forEach { item in
        print(item.value)
    }
}
