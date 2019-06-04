class BaseValidator < Dry::Validation::Schema
  configure do
    # predicates(CustomSchemaPredicates)
    config.messages = :i18n
  end
end
