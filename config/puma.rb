environment     "development"
threads         16, 32
pidfile         "/var/run/app/tagslide.pid"
state_path      "/var/run/app/tagslide.state"
bind            "unix:///var/run/app/tagslide0.sock"

# Add a worker per CPU core
workers         %x{grep -c processor /proc/cpuinfo}.strip
