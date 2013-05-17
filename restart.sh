#/bin/bash

# Check if the Sinatra app is still running
if ps aux | grep "ruby app.rb" | grep -v "grep"
then
  # Carry on, don't persist log in order to avoid spam
  echo "$(date) UberNews running successefully"
else
  cd /var/lamernews
  # Log this occurange
  echo "$(date) Darm, UberNews crashed again! :(" >> ./crash-log.txt
  # Restart the Sinatra app
  ruby app.rb &
  # Restart Apache because for some reason it no longer forwards correctly to
  # the application port once it restarts---TODO investigate
  /etc/init.d/apache2 restart
fi
