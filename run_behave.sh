#!/bin/bash

# Just run specific tag directly
python3 -m behave -t "@dashboard_filter" --no-skipped

## Note ##

# Make this script executable (only once needed). need to do this the first time. running in terminal
# chmod +x run_behave.sh

# For running in terminal
# ./run_behave.sh