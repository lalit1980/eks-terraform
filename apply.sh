#!/bin/bash
# vim: set ft=sh

set -eux

if [ "$TERRAFORM_ACTION" != "plan" ] && \
    [ "$TERRAFORM_ACTION" != "apply" ]; then
  echo 'must set $TERRAFORM_ACTION to "plan" or "apply"' >&2
  exit 1
fi