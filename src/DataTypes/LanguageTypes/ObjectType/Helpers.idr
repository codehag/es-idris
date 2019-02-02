module ObjectType.Helpers
import ObjectType.Type

||| ------- Internal Helpers ----------
export
_findProperty : ( propertyKey : String ) -> ( keys : List (String, a)) -> Maybe a
_findProperty propertyKey [] = Nothing
_findProperty propertyKey ((y, a) :: xs) = case (y == propertyKey) of
                                  True => Just a
                                  False => _findProperty propertyKey xs

export
_defineInList : ( List (String, DataProperty)) ->
               ( propertyKey : String ) ->
               ( value : String ) ->
               List (String, DataProperty)
_defineInList [] propertyKey value = [(propertyKey, MkDataProperty value False False False)]
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
_extractKeys : List (String, DataProperty) -> List String
_extractKeys [] = []
_extractKeys ((y, x) :: xs) = y :: _extractKeys xs

||| Delete Helpers
export
_removeFromList : ( list : List (String, DataProperty)) ->
               ( propertyKey : String ) ->
               List (String, DataProperty)
_removeFromList [] propertyKey = []
_removeFromList ((y, x) :: xs) propertyKey =
  case (y == propertyKey) of
       False => (y, x) :: _removeFromList xs propertyKey
       True => xs

export
_delete : ( this : Object ) -> ( propertyKey : String ) -> Object
_delete this propertyKey =
  record { _Properties_ = _removeFromList (_Properties_ this) propertyKey } this


