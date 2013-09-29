 :verbose: false
 :pidfile: /var/run/app/sidekiq.pid
 :concurrency: 10
 :queues:
   - [mailer, 3]
