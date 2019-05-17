class Person < ApplicationRecord
  self.table_name = 'person'

  has_many :name_variants
  has_many :previous_incarnations, foreign_key: 'leaf_person_id'
  has_many :subsequent_incarnations, foreign_key: 'root_person_id'

  def tbrc_link
    "http://purl.bdrc.io/resource/#{tbrc_rid}.ttl"
  end
end
