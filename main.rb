require 'date'
require 'ferrum'

today = Date.today
browser = Ferrum::Browser.new(process_timeout: 30)
page = browser.create_page
page.go_to("https://github.com/#{ENV.fetch('TARGET_GITHUB_USERNAME')}")
# frame = page.frames.first
sleep 1 # Wait for frame load
cell = page.at_xpath("//td[@data-date='#{today}']")
unless cell
  sleep 1 # Wait for frame load
  cell = page.at_xpath("//td[@data-date='#{today}']") # Retry
end
unless cell # It's UTC based so sometimes there's no cell for today
  puts "The cell for today doesn't exist, run it again after #{Time.utc(today.year, today.month, today.day).localtime}"
  exit 0
end

level = cell.attribute('data-level')
exit 1 if level.nil? # Fatal, something is wrong

message = "Today's contribution level: #{level}"
if ENV['GITHUB_CONTRIBUTION_NOTIFIER_DEBUG']
  puts message
else
  require 'slack-notifier'

  url = ENV.fetch('SLACK_WEBHOOK_URL')
  notifier = Slack::Notifier.new(url)
  notifier.ping message
end
