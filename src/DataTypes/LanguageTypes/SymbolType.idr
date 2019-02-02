||| 6.1.5 The Symbol Type
module SymbolType

||| The Symbol type is the set of all non-String values that may be used as the key of an Object
||| property (6.1.7). Each possible Symbol value is unique and immutable.
||| Each Symbol value immutably holds an associated value called [[Description]] that is either
||| undefined or a String value.
record Symbol where
  constructor MkSymbol
  _Description_ : Maybe String
