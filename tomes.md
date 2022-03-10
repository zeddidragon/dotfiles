# Tomes of sacred knowledge

## Command for opening vim in a temporary window in tmux when using :editor (Ctrl - i)

```
  set editorcmd tmux new-window -n firefox 'vim -f %f; tmux wait-for -S firefox-neww-done' \; wait-for firefox-neww-done
```

Source: https://quinoa42.github.io/en/oceanus/tridactyl-editorcmd-with-tmux/

## Open tmux pane in same directory (edit tmux.conf)
```
  # Set new panes to open in current directory
  bind c new-window -c "#{pane_current_path}"
  bind '"' split-window -c "#{pane_current_path}"
  bind % split-window -h -c "#{pane_current_path}"
```

Source: https://gist.github.com/william8th/faf23d311fc842be698a1d80737d9631
