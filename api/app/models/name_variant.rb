class NameVariant < ApplicationRecord
  self.table_name = 'name_variant'
  has_one :language_type
end
