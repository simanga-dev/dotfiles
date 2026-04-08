#!/bin/sh

for proc in nnn rmpc bluetui fzf btop yazi wiremix nchat; do
	killall "$proc" 2>/dev/null || true
done

kill -9 $(pgrep -af "nvim.*my-notes/notes.*\.md" | awk '{print $1}') 2>/dev/null || true
