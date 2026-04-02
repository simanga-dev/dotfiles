#!/usr/bin/env sh

fd -HI -t d '(^[.]git$|[.]git$)' "$HOME" \
  | while IFS= read -r path; do
      case "$path" in
        */.git/)
          printf '%s\n' "${path%/.git/}"
          ;;
        *.git/)
          printf '%s\n' "${path%/}"
          ;;
      esac
    done \
  | grep -v '/\.' \
  | sort -u \
  | sed "s|$HOME|~|;s|^|\x1b[32m📁\x1b[0m |"
