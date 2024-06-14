#!/bin/sh

export OUMAN_USER="$(cat "${CREDENTIALS_DIRECTORY:-.}/.ouman-user")"
export OUMAN_PASSWORD="$(cat "${CREDENTIALS_DIRECTORY:-.}/.ouman-pass")"
