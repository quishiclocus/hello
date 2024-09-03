#!/usr/bin/env bash
rsync -av --progress ~/.config/ ~/src/quishiclocus/hello/mac-config --exclude github-copilot --exclude iterm2
