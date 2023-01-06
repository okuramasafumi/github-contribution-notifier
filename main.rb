require 'date'
require 'mechanize'

today = Date.today
agent = Mechanize.new
page = agent.get("https://github.com/#{ENV.fetch('TARGET_GITHUB_USERNAME')}")
cell = page.search("//rect[@data-date='#{today}']").first
unless cell # It's UTC based so sometimes there's no cell for today
  puts "The cell for today doesn't exist, run it again after #{Time.utc(today.year, today.month, today.day).localtime}"
  exit 0
end

level = cell.attributes['data-level'].value
exit 1 if level.nil? # Fatal, something is wrong

require 'slack-notifier'

url = ENV.fetch('SLACK_WEBHOOK_URL')
notifier = Slack::Notifier.new(url)
notifier.ping "Today's contribution level: #{level}"
