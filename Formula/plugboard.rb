# Rendered by scripts/release.sh. Homebrew downloads release assets anonymously,
# so the repository (or a separate release repository) must be public.
class Plugboard < Formula
  desc "claude.ai connector tools as shell commands, at zero model tokens"
  homepage "https://github.com/obrier/plugboard"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.3/plugboard-0.1.3-darwin-arm64.tar.gz"
      sha256 "f0fbc5c98792c9792226345201b4d26a8957a15c5c668a2e648a8ea78a62ea4d"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.3/plugboard-0.1.3-darwin-x64.tar.gz"
      sha256 "5d8f6c68c660e05c8db67164d1d116e531ef5780e0ab621fa1efd4f79c6200d9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.3/plugboard-0.1.3-linux-arm64.tar.gz"
      sha256 "60e19c7571939859356a36f936b365f3e297af6b2860342e787ca6f01f7139bc"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.3/plugboard-0.1.3-linux-x64.tar.gz"
      sha256 "660d628f8fbcfc7649e5dc1827ac1721ddf471497e45a78eac6d58f65e40b663"
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
