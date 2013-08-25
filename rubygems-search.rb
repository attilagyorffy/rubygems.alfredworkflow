require 'bundler/setup'
require 'gems'

require 'rexml/document'

gems = []

query = ARGV[0]

  Gems.search(query)[0..4].each_with_index do |gem, index|
    gems << {
      name: gem['name'],
      info: gem['info']
    }
  end
  
document = REXML::Element.new("items")
gems.each_with_index do |gem, index|
  
  item = REXML::Element.new('item')
  item.add_attributes({
    'uid'          => gem[:name],
    'arg'          => gem[:name],
  })
  REXML::Element.new("title", item).text    = gem[:name]
  REXML::Element.new("subtitle", item).text = gem[:info]

  icon = REXML::Element.new("icon", item)
  icon.text = 'icon.png'

  document << item
end

puts document.to_s
