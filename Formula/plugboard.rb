# Rendered by scripts/release.sh. Homebrew downloads release assets anonymously,
# so the repository (or a separate release repository) must be public.
class Plugboard < Formula
  desc "claude.ai connector tools as shell commands, at zero model tokens"
  homepage "https://github.com/obrier/plugboard"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.2.0/plugboard-0.2.0-darwin-arm64.tar.gz"
      sha256 "a62806b040e0c8933b89db159ef3933e98e9a1d02c94d0321d8c823e76fb03df"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.2.0/plugboard-0.2.0-darwin-x64.tar.gz"
      sha256 "51e55f9a5cf14ea0224a05f31c63c86b88f219a68705fdd2300c08de3186e3cb"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.2.0/plugboard-0.2.0-linux-arm64.tar.gz"
      sha256 "5c2a9cf1a40b6e4bae8449555c44a4b95c63729c8eb3ecb67c6f0844c835483d"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.2.0/plugboard-0.2.0-linux-x64.tar.gz"
      sha256 "e3be243fcd3fb73f603f3ffeeb816fb3b9d8facd56d9e1367b00ae2d512b5409"
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
