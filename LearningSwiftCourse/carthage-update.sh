
# Set git to use the osxkeychain credential helper
git config --global credential.helper osxkeychain

carthage update $@ --no-build --no-use-binaries --platform iOS
