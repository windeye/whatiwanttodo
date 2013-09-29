# Use this file to easily define all of your cron jobs.
#
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
set :output, Rails.root.join("/log/crontask.log")
#set :environment, 'development'
every 10.minutes do
  runner "Powerpoint.adjust_scores_crontab", environment => "development"
end
#every :hour do
#  runner "Powerpoint.adjust_scores_crontab"
#end
