||| Primitive Language Types
||| Boolean, String, and Number are taken from the idris implementation
||| however these can also be generated to have object representations.
||| this is taken care of in PrimitivePrototypes.idr
module PrimitiveTypes

||| The Undefined type has exactly one value, called undefined. Any variable that has not been
||| assigned a value has the value undefined.
data Undefined

||| The Null type has exactly one value, called null.
data Null

||| The Number type has exactly 18437736874454810627 (that is, 264-253+3) values, representing the
||| double-precision 64- bit format IEEE 754-2008 values as specified in the IEEE Standard for
||| Binary Floating-Point Arithmetic, except that the 9007199254740990 (that is, 253-2) distinct
||| “Not-a-Number” values of the IEEE Standard are represented in ECMAScript as a single special
||| NaN value. (Note that the NaN value is produced by the program expression NaN.) In some
||| implementations, external code might be able to detect a difference between various
||| Not-a-Number values, but such behaviour is implementation-dependent; to ECMAScript code, all
||| NaN values are indistinguishable from each other.
||| There are two other special values, called positive Infinity and negative Infinity. For brevity,
||| these values are also referred to for expository purposes by the symbols +∞ and -∞,
||| respectively. (Note that these two infinite Number values are produced by the program
||| expressions +Infinity (or simply Infinity) and -Infinity.)
||| The other 18437736874454810624 (that is, 264-253) values are called the finite numbers. Half of
||| these are positive numbers and half are negative numbers; for every finite positive Number value
||| there is a corresponding negative value having the same magnitude.
||| Note that there is both a positive zero and a negative zero. For brevity, these values are also
||| referred to for expository purposes by the symbols +0 and -0, respectively. (Note that these two
||| different zero Number values are produced by the program expressions +0 (or simply 0) and -0.)
||| ---
||| Note: this implementation takes its finite number implementation from Idris' Int values
||| TODO: union of Number and Int, the current version is ugly
data Number =
  Num Int
  | PositiveInfinity
  | NegativeInfinity
  | Infinity
  | PositiveZero
  | NegativeZero
  | NaN
