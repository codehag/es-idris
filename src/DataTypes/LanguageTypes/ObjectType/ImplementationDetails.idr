||| Implmentation details not reflected in the specification
module ObjectType.ImplementationDetails
import ObjectType.Type

||| ------- Internal Helpers ----------
export
_findProperty : ( propertyKey : String ) -> ( keys : List (String, a)) -> Maybe a
_findProperty propertyKey [] = Nothing
_findProperty propertyKey ((y, a) :: xs) = case (y == propertyKey) of
                                  True => Just a
                                  False => _findProperty propertyKey xs

export
_defineInList : ( List (String, AccessorProperty)) ->
               ( propertyKey : String ) ->
               ( value : String ) ->
               List (String, AccessorProperty)
_defineInList [] propertyKey value = [(propertyKey, MkAccessorProperty value Nothing Nothing False False False)]
_defineInList ((y, x) :: xs) propertyKey value =
  case (y == propertyKey) of
       False => (y, x) :: _defineInList xs propertyKey value
       True => (y, record { _Value_ = value } x ) :: xs

export
_assignmentResultBoolean : ( result : Maybe a ) -> Bool
_assignmentResultBoolean Nothing = False
_assignmentResultBoolean (Just x) = True

export
_assignmentResult : Maybe a -> b -> Either b a
_assignmentResult maybe b = maybeToEither b maybe

export
_extractKeys : List (String, AccessorProperty) -> List String
_extractKeys [] = []
_extractKeys ((y, x) :: xs) = y :: _extractKeys xs

||| Delete Helpers
export
_removeFromList : ( list : List (String, AccessorProperty)) ->
               ( propertyKey : String ) ->
               List (String, AccessorProperty)
_removeFromList [] propertyKey = []
_removeFromList ((y, x) :: xs) propertyKey =
  case (y == propertyKey) of
       False => (y, x) :: _removeFromList xs propertyKey
       True => xs

export
_delete : ( this : Object ) -> ( propertyKey : String ) -> Object
_delete this propertyKey =
  record { _AccessorProperties_ = _removeFromList (_AccessorProperties_ this) propertyKey } this


