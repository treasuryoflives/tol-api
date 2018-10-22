require 'net/http'
require 'nokogiri'
require 'csv'

terms = []

uri = URI('https://www.loc.gov/collections/tibetan-oral-history-project/articles-and-essays/glossary/')
res = Net::HTTP.get_response(uri)
html = res.body

doc = Nokogiri::HTML(html, nil, 'UTF-8')
counter = 0
lists = doc.css('article.article ul.plain')
lists.each do |list|
  list.children.each do |item|
    if item.at('strong')
      strong = item.at('strong').xpath('text()').text
      square = strong.include?('[') ? strong[/\[(.*)\]/, 1] : ''
      name = strong.include?('[') ? strong[/(.*) \[/, 1] : strong 
      definition = item.xpath('text()').text
      terms << [name, square, definition]
    end
  end
end

CSV.open('glossary.csv', 'w') do |csv|
  terms.each do |term|
    csv << term
  end
end
