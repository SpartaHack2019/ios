//  This file was automatically generated and should not be edited.

import Apollo

public final class AllPostsQuery: GraphQLQuery {
  public let operationDefinition =
    "query AllPosts {\n  allPosts {\n    __typename\n    id\n    image\n    description\n    adoption\n    adoptionUrl\n    likes\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allPosts", type: .list(.object(AllPost.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allPosts: [AllPost?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allPosts": allPosts.flatMap { (value: [AllPost?]) -> [ResultMap?] in value.map { (value: AllPost?) -> ResultMap? in value.flatMap { (value: AllPost) -> ResultMap in value.resultMap } } }])
    }

    public var allPosts: [AllPost?]? {
      get {
        return (resultMap["allPosts"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllPost?] in value.map { (value: ResultMap?) -> AllPost? in value.flatMap { (value: ResultMap) -> AllPost in AllPost(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllPost?]) -> [ResultMap?] in value.map { (value: AllPost?) -> ResultMap? in value.flatMap { (value: AllPost) -> ResultMap in value.resultMap } } }, forKey: "allPosts")
      }
    }

    public struct AllPost: GraphQLSelectionSet {
      public static let possibleTypes = ["PostType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("image", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("adoption", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("adoptionUrl", type: .scalar(String.self)),
        GraphQLField("likes", type: .nonNull(.scalar(Int.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, image: String, description: String, adoption: Bool, adoptionUrl: String? = nil, likes: Int) {
        self.init(unsafeResultMap: ["__typename": "PostType", "id": id, "image": image, "description": description, "adoption": adoption, "adoptionUrl": adoptionUrl, "likes": likes])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var image: String {
        get {
          return resultMap["image"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var adoption: Bool {
        get {
          return resultMap["adoption"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "adoption")
        }
      }

      public var adoptionUrl: String? {
        get {
          return resultMap["adoptionUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "adoptionUrl")
        }
      }

      public var likes: Int {
        get {
          return resultMap["likes"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "likes")
        }
      }
    }
  }
}