#!/bin/sh

set -e

# activate our virtual environment here
. $(poetry env info --path)/bin/activate

# You can put other setup logic here

# Evaluating passed command:
eval "exec $@"