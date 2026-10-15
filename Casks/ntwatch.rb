cask "ntwatch" do
  version "2.0"
  sha256 "7058ba445de69bb43665991b61002518f5ded62c2d15d4f81cd79e0a106f1e53"

  url "https://github.com/lolasanchezz/ntwatch/releases/download/v#{version}/ntwatch-#{version}-macos-universal.zip"
  name "ntwatch"
  desc "Network monitor that matches sockets and traffic to processes"
  homepage "https://github.com/lolasanchezz/ntwatch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "ntwatch.app"
  binary "#{appdir}/ntwatch.app/Contents/MacOS/ntwatch"

  zap trash: [
    "~/Library/Caches/com.wails.ntwatch",
    "~/Library/Saved Application State/com.wails.ntwatch.savedState",
    "~/Library/WebKit/com.wails.ntwatch",
  ]

  caveats <<~EOS
    ntwatch isn't signed with an Apple Developer ID, so macOS will block it
    the first time you open it. Go to System Settings → Privacy & Security
    and click "Open Anyway", or run:

      xattr -dr com.apple.quarantine #{appdir}/ntwatch.app

    Run `ntwatch --tui` to use it in the terminal instead of a window.
  EOS
end
