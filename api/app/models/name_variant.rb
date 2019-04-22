class NameVariant < ApplicationRecord
  self.table_name = 'name_variant'
  belongs_to :language_type
  belongs_to :encoding_type
end
