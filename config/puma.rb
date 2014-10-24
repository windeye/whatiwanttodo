environment     "production"
threads         16, 32
pidfile         "/var/run/app/tagslide.pid"
state_path      "/var/run/app/tagslide.state"
bind            "unix:///var/run/app/tagslide.sock"

# Add a worker per CPU core
workers         %x{grep -c processor /proc/cpuinfo}.strip
