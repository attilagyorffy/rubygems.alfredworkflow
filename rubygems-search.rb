require 'bundler/setup'
require 'gems'

require 'rexml/document'

query = ARGV[0]

xml_items = REXML::Element.new('items')

Gems.search(query)[0..8].each do |gem_data|
  
  gem_name = gem_data['name']
  gem_info = gem_data['info']
  
  xml_item = REXML::Element.new('item')
  xml_item.add_attributes({
    'uid' => gem_name,
    'arg' => gem_name,
  })

  REXML::Element.new('title',     xml_item).text = gem_name
  REXML::Element.new('subtitle',  xml_item).text = gem_info
  REXML::Element.new('icon',      xml_item).text = 'icon.png'

  xml_items << xml_item
end
  
puts xml_items.to_s
