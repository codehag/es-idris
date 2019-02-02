module DataTypes.SpecificationTypes.Record
import DataTypes.LanguageTypes.LanguageTypes

export
record Record where
  constructor MkRecord
  _Fields_ : List (String, LanguageType)

_lookup : ( keys : List (String, LanguageType)) -> ( key : String ) -> Maybe Type
_lookup [] key = Nothing
_lookup ((y, a) :: xs) key = case (y == key) of
                                  True => Just a
                                  False => _lookup xs key

lookupInRecord : (rec : Record ) -> ( key : String ) ->  Maybe Type
lookupInRecord rec key = _lookup (_Fields_ rec) key

