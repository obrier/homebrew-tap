# Rendered by scripts/release.sh. Homebrew downloads release assets anonymously,
# so the repository (or a separate release repository) must be public.
class Plugboard < Formula
  desc "claude.ai connector tools as shell commands, at zero model tokens"
  homepage "https://github.com/obrier/plugboard"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.0/plugboard-0.1.0-darwin-arm64.tar.gz"
      sha256 "66a388f5fc37b87584a1ebb1fd35032f6804c7dd0daf2f238594ec7360267687"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.0/plugboard-0.1.0-darwin-x64.tar.gz"
      sha256 "9c505bd9b8cf340c3042cffda556da573e6fc8f47398731d59a502afc9c0b286"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.0/plugboard-0.1.0-linux-arm64.tar.gz"
      sha256 "708198e8ada9bde5f0f2d31b8d5802f6f08ac2a6f37f5a47c9f862568622ba6e"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.0/plugboard-0.1.0-linux-x64.tar.gz"
      sha256 "0a05c2a086d2cda312d97b99bbccc9fcdbbf081bcc6e4b32bc3eba50210ac07b"
    end
  end

  def install
    bin.install "plugboard"
    pkgshare.install "policy.example.toml", "transforms.example.toml", "skills"
  end

  def caveats
    <<~EOS
      Plugboard drives Claude Code's internal control protocol: it needs Claude Code
      installed and logged in (`claude /login`), and may break after a Claude Code update
      (`plugboard doctor` says so). It is not an official Anthropic tool.

      Start with:
        plugboard refresh && plugboard doctor
      Example policy: #{opt_pkgshare}/policy.example.toml → ~/.config/plugboard/policy.toml
      Time transforms: #{opt_pkgshare}/transforms.example.toml → ~/.config/plugboard/transforms.toml
      Agent skills: #{opt_pkgshare}/skills
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/plugboard --version")
  end
end
