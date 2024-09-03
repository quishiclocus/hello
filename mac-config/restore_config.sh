#!/usr/bin/env bash
rsync -av --progress ~/src/quishiclocus/hello/mac-config ~/.config/ --exclude github-copilot --exclude iterm2
