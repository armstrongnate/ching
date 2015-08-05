Ching
=======

Ching is a budget app for iOS.

## Tech Stack
- Objective-C (language)
- [Carthage](https://github.com/Carthage/Carthage) (dependency management)
- Core Data (persistence)
- [Specta](https://github.com/specta/specta), [Expecta](https://github.com/specta/expecta), and [OCMock](http://ocmock.org/) (tests)

## Adding Core Data Entities

I found that I really like this approach to [Core Data models and model-objects](http://www.objc.io/issues/4-core-data/core-data-models-and-model-objects/).

There is a `BaseEntity` class that inherits from `NSManagedObject` and from which
all other entities should inherit. It has three base properties:

* `identifier`: a unique identifier **required** (must be greater than zero)
* `createdAt`: the date that it was created **required**
* `updatedAt`: last updated timestamp **optional**

So to add a new entity the following steps are required:

1. Add the entity to the `xcdatamodeld` file
2. In addition to any custom fields, add the three base attributes listed above. Make sure to mark them as required appropriately and set `identifier` to have a min of 1.
3. Use the Xcode tool to generate the NSManagedObject subclass (only once) and make it inherit from `BaseEntity`, removing the base properties.

Use the Xcode generator the first time to generate the subclasses but never again.
I'm not using categories or [mogenerator](https://github.com/rentzsch/mogenerator)
to extend the functionality of the classes. The article linked above puts it nicely:

> You may wonder how to implement custom code in managed object subclasses if Xcode keeps overwriting these files when regenerating them. Well, the answer is pretty simple: don’t generate them with Xcode. If you think about it, the generated code in these classes is trivial and very easy to write yourself, or generate once and then keep up to date manually. It’s really just a bunch of property declarations.
>
> There are other solutions like putting the custom code in a category, or using tools like mogenerator, which creates a base class for each entity and a subclass of it where the user-written code is supposed to go. But none of these solutions allow for a flexible class hierarchy independent of the entity hierarchy. So at the cost of writing a few lines of trivial code, our advice is to just write those classes manually.
