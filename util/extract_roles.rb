roles = {}

Dir.glob('/vagrant/roles/*.ttl').sort.each do |file|
  if file != '.' && file != '..'
    data = File.read(file)
    record_number = data.match(/bdr:(R[A-Z0-9]+)/)[1]
    role_match = data.match(/skos:prefLabel.*"(.*)\/?"@bo-x-ewts(.*"(.*)"@en)? ;/)
    if role_match
      roles[record_number] = role_match[1] + ',' + (role_match[3] || '')
    else
      roles[record_number] = 'none found'
    end
  end
end

File.open('roles.txt', 'w') do |file|
  roles.each do |key, value|
    file.write("#{key}, #{value}\r\n")
  end
end
