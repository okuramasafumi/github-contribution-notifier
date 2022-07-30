require 'mechanize'

agent = Mechanize.new
page = agent.get("https://github.com/#{ENV.fetch('TARGET_GITHUB_USERNAME')}")
count = page.search("//rect[@data-date='#{Date.today}']").first.attributes['data-count'].value
exit 1 if count.nil?

require 'slack-notifier'

url = ENV.fetch('SLACK_WEBHOOK_URL')
notifier = Slack::Notifier.new(url)
notifier.ping "Today's contribution count: #{count}"
