require 'rexml/document'

class AlfredFeedback
  def initialize
    @items = []
  end
  
  def <<(item)
    @items << item
  end
  
  def to_xml
    REXML::Element.new('items').tap do |items_xml|
      @items.each do |item|
        items_xml << item.to_xml
      end
    end
  end

  def to_s
    to_xml.to_s
  end
end
