module ObjectType.Methods
import ObjectType.Type
import ObjectType.ImplementationDetails

||| Determine the object that provides inherited properties for this object. A null value indicates
||| that there are no inherited properties.
export
getPrototypeOf : ( this : Object ) -> Maybe Object
getPrototypeOf this = _Prototype_ this

||| Associate this object with another object that provides inherited properties. Passing null
||| indicates that there are no inherited properties. Returns true indicating that the operation was
||| completed successfully or false indicating that the operation was not successful.
export
setPrototypeOf : ( this : Object ) -> ( prototype : Maybe Object ) -> Object
setPrototypeOf this prototype = record { _Prototype_ = prototype } this

||| Determine whether it is permitted to add additional properties to this object.
export
isExtensible : ( this : Object ) -> Bool
isExtensible this = _Extensible_ this

||| Control whether new properties may be added to this object. Returns true if the operation was
||| successful or false if the operation was unsuccessful.
||| ---
||| NOTE: Ignoring the spec for now, should return true or false if the operation is successful
export
preventExtensions : ( this : Object ) -> Object
preventExtensions this = record { _Extensible_ = False } this

||| Return a Property Descriptor for the own property of this object whose key is propertyKey, or
||| undefined if no such property exists.
export
getOwnProperty : ( this : Object ) -> ( propertyKey : String ) -> Maybe AccessorProperty
getOwnProperty this propertyKey = let keys = _AccessorProperties_ this in
                                      _findProperty propertyKey keys


||| Create or alter the own property, whose key is propertyKey, to have the state described by
||| PropertyDescriptor. Return true if that property was successfully created/updated or false if
||| the property could not be created or updated.
||| ---
||| NOTE: Ignoring the spec for now, should return true or false if the operation is successful
||| also ignoring actually modifying the object until later, returning a new object. Currently
||| returns the new immutable object
export
defineOwnProperty : ( this : Object ) -> ( propertyKey : String ) -> ( value : String ) -> Object
defineOwnProperty this propertyKey value =
  record { _AccessorProperties_ = _defineInList (_AccessorProperties_ this) propertyKey value } this

||| Return a Boolean value indicating whether this object already has either an own or inherited
||| property whose key is propertyKey.
export
hasProperty : ( this : Object ) -> ( propertyKey : String ) -> Bool
hasProperty this propertyKey = case (getOwnProperty this propertyKey) of
                                    Nothing => False
                                    Just a => True

||| Return the value of the property whose key is propertyKey from this object. If any ECMAScript
||| code must be executed to retrieve the property value, Receiver is used as the this value
||| when evaluating the code.
||| ---
||| NOTEget also within prototype chain unlike getOwnProperty? no function yet as we only have
||| Simple Language Types. True false return value not complete yet
export
get : ( this : Object ) -> ( propertyKey : String ) -> Maybe AccessorProperty
get this propertyKey = case (getOwnProperty this propertyKey) of
                            Nothing => case (_Prototype_ this) of
                                            Nothing => Nothing
                                            Just a => get a propertyKey
                            Just a => Just a

||| Set the value of the property whose key is propertyKey to value. If any ECMAScript code must be
||| executed to set the property value, Receiver is used as the this value when evaluating
||| the code. Returns true if the property value was set or false if it could not be set.
||| ---
||| NOTE: set also within prototype chain unlike defineOwnProperty? no function yet as we only have
||| Simple Language types. True false return value not complete yet
export
set : ( this : Object ) -> ( propertyKey : String ) -> ( value : String ) -> Object
set this propertyKey value = defineOwnProperty this propertyKey value

||| Remove the own property whose key is propertyKey from this object. Return false if the property
||| was not deleted and is still present.  Return true if the property was deleted or is not present.
||| ---
||| NOTE: Returns a Maybe Object with the property deleted. To fulfill the spec, this
||| Method must be used with `_assignmentResultBoolean` in the runtime
export
delete : ( this : Object ) -> ( propertyKey : String ) -> Maybe Object
delete this propertyKey =
  case (getOwnProperty this propertyKey) of
       Nothing => Nothing
       Just x => Just (_delete this propertyKey)

||| Return a List whose elements are all of the own property keys for the object.
export
ownPropertyKeys : ( this : Object ) -> List String
ownPropertyKeys this = _extractKeys (_AccessorProperties_ this)

