# Rendered by scripts/release.sh. Homebrew downloads release assets anonymously,
# so the repository (or a separate release repository) must be public.
class Plugboard < Formula
  desc "claude.ai connector tools as shell commands, at zero model tokens"
  homepage "https://github.com/obrier/plugboard"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.2/plugboard-0.1.2-darwin-arm64.tar.gz"
      sha256 "f0b5c951e3e94ef369fa063b7361d63d0eac4dc3589c7a40231c9216dbd30cee"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.2/plugboard-0.1.2-darwin-x64.tar.gz"
      sha256 "5684f5b44acb2a3344011c7175148f72dfd54c274a998d68a762adca16aca16c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.2/plugboard-0.1.2-linux-arm64.tar.gz"
      sha256 "a7a0390f6a26c0a01039f527f459cf9485920d28b432619e9442cddf2697b803"
    end
    on_intel do
      url "https://github.com/obrier/plugboard/releases/download/v0.1.2/plugboard-0.1.2-linux-x64.tar.gz"
      sha256 "c1a6398860345d8e974ce583c31c5388b8d6ac22d9e2171cb3d595b500388ee0"
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
