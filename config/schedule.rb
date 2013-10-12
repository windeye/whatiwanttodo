# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
#   runner "Powerpoint.adjust_scores_crontab", environment => "development"
# end
# set :environment, 'development'

set :output, File.join( File.dirname( __FILE__ ), '..', 'log', 'scheduled_tasks.log' ) 
every :hour do
  runner "Powerpoint.adjust_scores_crontab"
end
