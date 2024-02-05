/Applications/Godot.app/Contents/MacOS/Godot --headless --verbose --export-release "Web" /build/web/index.html
npx local-web-server --https --cors.embedder-policy "require-corp" --cors.opener-policy "same-origin" --directory "./build/web" &> /dev/null
tell application "Arc"
    make new tab with properties {URL:"https://www.reddit.com"}
    activate
end tell