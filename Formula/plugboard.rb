# Rendered by scripts/release.sh. Homebrew downloads release assets anonymously,
# so the repository (or a separate release repository) must be public.
class Plugboard < Formula
  desc "claude.ai connector tools as shell commands, at zero model tokens"
  homepage "https://github.com/obrier/plugboard"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.1/plugboard-0.1.1-darwin-arm64.tar.gz"
      sha256 "fbda91521fd4cd751aec951b5dcdf7b97799e23a7bc24410f81fc63767e10cb7"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.1/plugboard-0.1.1-darwin-x64.tar.gz"
      sha256 "58d23dfe2127855dc97b1a1e20724b6a6c66da636b0b55f48121390422cb65fa"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.1/plugboard-0.1.1-linux-arm64.tar.gz"
      sha256 "c372d5aea61702ed2186e11af48e88837b7ec21232d3f3cba1533dfd62d93be2"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.1/plugboard-0.1.1-linux-x64.tar.gz"
      sha256 "10ea2beeb954130e5508863349b851fed0ac0009ef323d5eaccc01a366c4f8bf"
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
