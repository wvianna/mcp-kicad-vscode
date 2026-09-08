#!/usr/bin/env bash

export PYTHONPATH="/snap/kicad/22/usr/lib/python3/dist-packages"

export LD_LIBRARY_PATH="/snap/kicad/22/usr/lib/x86_64-linux-gnu:/snap/kicad/22/usr/lib/i386-linux-gnu:/snap/kicad/22/usr/lib:/snap/kicad/22/gnome-platform/usr/lib/x86_64-linux-gnu:/snap/kicad/22/gnome-platform/usr/lib:/snap/kicad/22/gnome-platform/lib"

export PATH="/snap/kicad/22/usr/bin:/snap/kicad/22/bin:$PATH"

export KICAD_PYTHON="/home/william/git/mcp-kicad-vscode/KiCAD-MCP-Server/.venv/bin/python"

exec /usr/bin/node "/home/william/git/mcp-kicad-vscode/KiCAD-MCP-Server/dist/index.js"
