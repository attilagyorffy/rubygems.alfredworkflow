$: << File.expand_path('./vendor/gems/gems-0.8.1/lib')
$: << File.expand_path('./lib')

require 'gems'
require 'alfred_feedback'
require 'alfred_feedback_item'

query = ARGV[0]

feedback = AlfredFeedback.new
gem_results = Gems.search(query)

if gem_results.any?

  gem_results.each do |gem_data|
    name    = gem_data['name']
    info    = gem_data['info']
    version = gem_data['version']
    subtitle = "#{version} - #{info}"

    feedback << AlfredFeedBackItem.new(name, :subtitle => subtitle)
  end
else
  feedback << AlfredFeedBackItem.new("No gems found for '#{query}'.", :subtitle => "Are you sure you're looking for the right thing?", :valid => false)
end

puts feedback
