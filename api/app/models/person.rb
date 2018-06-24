class Person < ApplicationRecord
  self.table_name = 'person'

  def tbrc_link
    "http://purl.bdrc.io/resource/#{tbrc_rid}.ttl"
  end
end
