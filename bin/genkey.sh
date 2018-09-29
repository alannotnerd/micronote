#!/bin/bash
export SECRET_KEY_BASE="$(bundle exec rake secret)"
