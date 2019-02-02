||| The basic building blocks of the ObjectType
module ObjectType.Type

mutual
  ||| 6.1.6 Object Type
  ||| An Object is logically a collection of properties. Each property is either a data property, or
  ||| an accessor property
  ||| ---
  ||| TODO: make it possible to have either String or Symbol as Key
  ||| TODO: make it possible to have either DataProperty or AccessorProperty as value
  public export
  record Object where
    constructor MkObject
    _Prototype_ : Maybe Object
    _Extensible_: Bool
    _DataProperties_ : List (String, DataProperty)
    _AccessorProperties_ : List (String, AccessorProperty)

  public export
  record Function where
    constructor MkFunction
    _Prototype_ : Maybe Function
    _Constructor_ : Maybe Function
    _Call_ : function
    _Extensible_ : Bool
    _DataProperties_ : List (String, DataProperty)
    _AccessorProperties_ : List (String, AccessorProperty)

  ||| A data property associates a key value with an ECMAScript language value and a set of Boolean
  ||| attributes.
  public export
  record DataProperty where
    constructor MkDataProperty
    _Value_ : a_value
    _Writable_, _Enumerable_, _Configurable_ : Bool

  ||| An accessor property associates a key value with one or two accessor functions, and a set of
  ||| Boolean attributes. The accessor functions are used to store or retrieve an ECMAScript language
  ||| value that is associated with the property.
  public export
  record AccessorProperty where
    constructor MkAccessorProperty
    _Value_ : value
    _Get_, _Set_ : Maybe Function
    _Writable_, _Enumerable_, _Configurable_ : Bool

|||
functionLength : DataProperty
functionLength = MkDataProperty 1 False False False

||| some small tests
test : DataProperty
test = MkDataProperty "test" False False False

fakeget : Function
fakeget = MkFunction Nothing Nothing True True [("length", functionLength)] []

fakeset : Function
fakeset = MkFunction Nothing Nothing True True [("length", functionLength)] []

test2 : AccessorProperty
test2 = MkAccessorProperty "test" (Just fakeget) (Just fakeset) False False False
