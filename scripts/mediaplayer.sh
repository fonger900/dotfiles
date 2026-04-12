#!/bin/bash

# Get media info using playerctl with JSON output for Waybar
playerctl metadata --format '{"text": "{{status}}: {{markup_escape(title)}} - {{markup_escape(artist)}}", "tooltip": "{{markup_escape(title)}} - {{markup_escape(artist)}} ({{markup_escape(album)}})", "alt": "{{status}}", "class": "{{status}}"}' --follow
