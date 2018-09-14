class Person < ApplicationRecord
  self.table_name = 'person'

  has_many :name_variants

  def tbrc_link
    "http://purl.bdrc.io/resource/#{tbrc_rid}.ttl"
  end
end
