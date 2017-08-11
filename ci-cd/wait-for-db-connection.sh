#!/usr/bin/env bash
while ! nc -z postgresql 5432; do sleep 1; done
