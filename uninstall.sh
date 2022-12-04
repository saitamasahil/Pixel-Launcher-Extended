[[ -e "/data/system/package_cache" ]] && rm -rf "/data/system/package_cache"

# Don't modify anything after this
[[ -f "$INFO" ]] && {
  while read LINE; do
    if [[ "$(echo -n "$LINE" | tail -c 1)" == "~" ]]; then
      continue
    elif [[ -f "$LINE~" ]]; then
      mv -f "$LINE~" "$LINE"
    else
      rm -rf "$LINE"
      while true; do
        LINE="$(dirname "$LINE")"
        [[ "$(ls -A $LINE 2>/dev/null)" ]] && break 1 || rm -rf "$LINE"
      done
    fi
  done < "$INFO"
  rm -rf "$INFO"
}