# Written by apps/hub/scripts/release-brew.ts in obrier/hub (decision 0129). Homebrew downloads release assets
# anonymously, so the zips are assets of this public tap's releases, tagged hub-v<version>.
class Hub < Formula
  desc "Command-line client of the Hub app's realm on this Mac"
  homepage "https://github.com/obrier/hub"
  version "0.1.0"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/obrier/homebrew-tap/releases/download/hub-v0.1.0/hub-0.1.0-darwin-arm64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/obrier/homebrew-tap/releases/download/hub-v0.1.0/hub-0.1.0-darwin-x64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "hub"
  end

  def caveats
    <<~EOS
      hub is a client of the realm the Hub app runs on this Mac: open the Hub app first.
      hub and the app speak one protocol; when they differ, hub says which to update.
    EOS
  end

  test do
    system "/usr/bin/codesign", "--verify", "--strict", bin/"hub"
  end
end
