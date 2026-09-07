#!/bin/bash
# bash_profile / tmux.conf assume bash is the login shell.
if [ "$SHELL" != "/bin/bash" ]; then
  echo "!!! Default shell is $SHELL, not /bin/bash"
  echo "To change to bash on mac, run:"
  echo "chsh -s /bin/bash"
fi
exit 0
