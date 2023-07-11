# config/unicorn.rb

# Set the number of worker processes
worker_processes ENV.fetch("WEB_CONCURRENCY") { 2 }.to_i

# Set the path to your application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", backlog: 64

# Set up logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"
