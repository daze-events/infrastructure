#!/usr/bin/env sh

set -e

MESSAGE_WIDTH=70
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
AWS_METADATA_ENDPOINT="http://169.254.169.254/latest/meta-data"
