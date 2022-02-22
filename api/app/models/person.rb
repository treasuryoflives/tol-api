class Person < ApplicationRecord
  self.table_name = 'person'

  has_many :name_variants
  has_many :previous_incarnations, foreign_key: 'leaf_person_id'
  has_many :subsequent_incarnations, foreign_key: 'root_person_id'
  has_many :teachers, foreign_key: 'student_person_id'
  has_many :students, foreign_key: 'teacher_person_id'
  has_one  :biography

  def tbrc_link
    "http://purl.bdrc.io/resource/#{tbrc_rid}.ttl"
  end

  def tol_link
    url_name = self.url_default_name || self.published_default_name
    url_name = url_name.gsub(' ', '-')
    "https://treasuryoflives.org/biographies/view/#{url_name}/#{self.person_id}"
  end

  def self.serialize_all
    File.open('all_persons.ttl', 'w') do |file|
      Person.all.each do |person|
        file.write SerializeResource.new(person, :ttl).serialize 
      end
    end
  end
end
