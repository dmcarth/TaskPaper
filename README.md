# TaskPaper
A small Swift library for parsing TaskPaper outlines. It is based on the same parsing algorithm used in [birch-outline](https://github.com/jessegrosjean/birch-outline).

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

Each `Item` represents a tree. For example, a project `Item` might contain other projects and tasks. Because of this, `Item` doubles as an AST with `sourceRange` and `contentRange` properties.

```Swift
projectItem.enumerate { (item) ->
    print(item.sourceRange)
}

// "{5, 12}"
```

TaskPaper tags are stored in a `tags` property that can be accessed via subscript. Each `Tag`, then, has an optional value string.

```Swift
if let tag = item["done"] {
    print(tag.value)
}

// "Optional("7-5-17")"
```
