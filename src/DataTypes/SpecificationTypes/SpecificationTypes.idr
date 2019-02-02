||| 6.2 ECMAScript Specification Types
||| A specification type corresponds to meta-values that are used within algorithms to describe the
||| semantics of ECMAScript language constructs and ECMAScript language types. The specification
||| types include Reference, List, Completion, Property Descriptor, Lexical Environment, Environment
||| Record, and Data Block. Specification type values are specification artefacts that do not
||| necessarily correspond to any specific entity within an ECMAScript implementation.
||| Specification type values may be used to describe intermediate results of ECMAScript expression
||| evaluation but such values cannot be stored as properties of objects or values of ECMAScript
||| language variables.
||| ---
||| Note about records and Lists:
||| The Record type is used to describe data aggregations within the algorithms of this
||| specification. A Record type value consists of one or more named fields. The value of each field
||| is either an ECMAScript value or an abstract value represented by a name associated with the
||| Record type. Field names are always enclosed in double brackets, for example [[Value]].
||| The List type is used to explain the evaluation of argument lists (see 12.3.6) in new
||| expressions, in function calls, and in other algorithms where a simple ordered list of values is
||| needed. Values of the List type are simply ordered sequences of list elements containing the
||| individual values. These sequences may be of any length. The elements of a list may be randomly
||| accessed using 0-origin indices. For notational convenience an array-like syntax can be used to
||| access List elements. For example, arguments[2] is shorthand for saying the 3rd element of the List
||| arguments.
||| ---
||| Implementation Note: We rely on the record data type, and the List data type built in within
||| Idris. Rather than using double brackets, we are using a single underscore. For example,
||| [[Value]] becomes _Value_
module SpecificationTypes

||| The Set type is used to explain a collection of unordered elements for use in the memory model.
||| Values of the Set type are simple collections of elements, where no element appears more than
||| once. Elements may be added to and removed from Sets.  Sets may be unioned, intersected, or
||| subtracted from each other.
data Set

||| The Relation type is used to explain constraints on Sets. Values of the Relation type are Sets
||| of ordered pairs of values from its value domain. For example, a Relation on events is a set of
||| ordered pairs of events. For a Relation R and two values a and b in the value domain of R, a R b
||| is shorthand for saying the ordered pair (a, b) is a member of R. A Relation is least with
||| respect to some conditions when it is the smallest Relation that satisfies those conditions.
data Relation

||| 6.2.3 The Completion Record Specification Type
||| The Completion type is a Record used to explain the runtime propagation of values and control
||| flow such as the behaviour of statements (break, continue, return and throw) that perform
||| nonlocal transfers of control.
data CompletionType = Normal | Break | Continue | Return | Throw

||| Values of the Completion type are Record values whose fields are defined as by Table 8. Such
||| values are referred to as Completion Records.
record CompletionRecord where
  constructor MkCompletionRecord
  _Type_ : CompletionType
  _Value_ : value
  _Target_ : Maybe String

||| 6.2.3.2 NormalCompletion
normalCompletion : value -> CompletionRecord
normalCompletion value = MkCompletionRecord Normal value Nothing

||| 6.2.3.3 ThrowCompletion
throwCompletion : value -> CompletionRecord
throwCompletion value = MkCompletionRecord Throw value Nothing
