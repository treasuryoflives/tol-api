class Person < ApplicationRecord
  self.table_name = 'person'

  has_many :name_variants
  has_many :previous_incarnations, foreign_key: 'leaf_person_id'
  has_many :subsequent_incarnations, foreign_key: 'root_person_id'
  has_many :teachers, foreign_key: 'student_person_id'
  has_many :students, foreign_key: 'teacher_person_id'

  def tbrc_link
    "http://purl.bdrc.io/resource/#{tbrc_rid}.ttl"
  end

  def self.serialize_all
    File.open('all_persons.ttl', 'w') do |file|
      Person.all.each do |person|
        file.write SerializeResource.new(person, :ttl).serialize 
      end
    end
  end
end
