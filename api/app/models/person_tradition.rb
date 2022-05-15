class PersonTradition < ApplicationRecord
  self.table_name = 'person_tradition_xref'

  has_one  :tradition, primary_key: 'tradition_id', foreign_key: 'tradition_id'
end
