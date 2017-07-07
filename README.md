# TaskPaper
A small Swift library for parsing TaskPaper outlines. It is based on the same parsing algorithm used in [birch-outline](https://github.com/jessegrosjean/birch-outline).

## Installation
Add this line to your dependencies in `Package.swift`.

```Swift
.Package(url: "https://github.com/dmcarth/TaskPaper.git", majorVersion: 0, minor: 0)
```

## Usage
```Swift
import TaskPaper

let outline = TaskPaper("Hello world")
```

A `TaskPaper` object holds an array of `Item`'s. An item can be a note, a project, or a task.

```Swift
for item in outline.items {
    print(item.type)
}

// ".note", ".project", ".task""
```

Each `Item` is a tree of items, representing tasks, subtasks, and so on. To traverse the tree by hand, use the `children` property on `Item`. Otherwise, use `enumerate(_:)`. The tree also doubles as an AST, with `sourceRange` and `contentRange` properties.

```Swift
projectItem.enumerate { (item) ->
    print(item.sourceRange)
}

// "{0, 5}" "{5, 12}" "{17, 6}"
```

TaskPaper tags are stored in a `tags` property that can be accessed via subscript. Each `Tag`, then, has an optional value string.

```Swift
if let tag = item["done"] {
    print(tag.value)
}

// "Optional("7-5-17")"
```

The parser does not currently have any concept of standard TaskPaper tags like @due or @done. The task of parsing dates and time spans is, currently, left to the user.
