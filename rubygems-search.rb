$: << File.expand_path('./vendor/gems/gems-0.8.1/lib')
$: << File.expand_path('./lib')

require 'gems'
require 'alfred_feedback'
require 'alfred_feedback_item'

query = ARGV[0]

feedback = AlfredFeedback.new

begin
  gem_results = Gems.search(query)

  if gem_results.any?

    gem_results.each do |gem_data|
      name    = gem_data['name']
      info    = gem_data['info']
      version = gem_data['version']
      arg     = ""
      subtitle = "#{version} - #{info}"

      feedback << AlfredFeedBackItem.new(name, :subtitle => subtitle, :arg => "https://rubygems.org/gems/#{name}")
    end
  else
    feedback << AlfredFeedBackItem.new("No gems found for '#{query}'.", :subtitle => "Are you sure you're looking for the right thing?", :valid => false)
  end
rescue SocketError => e
  rubygems_status_url = 'http://status.rubygems.org'
  feedback << AlfredFeedBackItem.new("Error: RubyGems seems unavailable.", :subtitle => "SocketError occurred: #{e}", :arg => rubygems_status_url)
end

puts feedback
