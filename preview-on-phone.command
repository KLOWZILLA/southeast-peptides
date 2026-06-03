#!/bin/zsh
cd "$(dirname "$0")" || exit 1
PORT=8080
IP=$(ipconfig getifaddr en0 2>/dev/null)
if [ -z "$IP" ]; then
  IP=$(ipconfig getifaddr en1 2>/dev/null)
fi
if [ -z "$IP" ]; then
  IP=$(ifconfig | awk '/inet / && $2 !~ /^127\./ { print $2; exit }')
fi
clear
echo "Southeast Peptides mobile preview"
echo "-----------------------------------"
echo "Keep this window open while viewing."
echo "Make sure your phone is on the same Wi-Fi as this Mac."
echo ""
if [ -n "$IP" ]; then
  echo "Open this on your phone:"
  echo "http://$IP:$PORT"
else
  echo "Could not detect local IP automatically."
  echo "Run: ipconfig getifaddr en0"
  echo "Then open: http://YOUR-IP:$PORT"
fi
echo ""
echo "Local Mac preview: http://localhost:$PORT"
echo "-----------------------------------"
python3 -m http.server "$PORT" --bind 0.0.0.0
