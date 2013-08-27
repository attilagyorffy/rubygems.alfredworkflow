require 'rexml/document'

class AlfredFeedBackItem
  attr_reader :title, :subtitle
  
  def initialize(title, options = {})
    @title = title
    @subtitle = options[:subtitle]
    @valid = options[:valid].nil? ? true : !!options[:valid]
  end
  
  def valid?
    @valid
  end
  
  def to_xml
    REXML::Element.new('item').tap do |xml_item|
      xml_item.add_attributes({
        'uid' => @title,
        'arg' => @title,
        'valid' => valid? ? 'yes' : 'no'
      })

      REXML::Element.new('title',     xml_item).text = @title
      REXML::Element.new('subtitle',  xml_item).text = @subtitle || @title
      REXML::Element.new('icon',      xml_item).text = 'icon.png'
    end
  end
end
