module LexicalEnvironments
import DataTypes.SpecificationTypes.Record

data EnvironmentRecord = DeclarativeEnvironmentRecord Record
                       | ObjectEnvironmentRecord Record
                       | GlobalEnvironmentRecord Record

hasBinding : (envRec: EnvironmentRecord) -> (n : string) -> Bool
