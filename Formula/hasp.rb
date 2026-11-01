class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.46"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.46/hasp_1.0.46_darwin_arm64.tar.gz"
      sha256 "6f4a41b7158dacecb3ec2d1ee83bcc933f3e290605f5c8303af33480f5577afb"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.46/hasp_1.0.46_darwin_amd64.tar.gz"
      sha256 "65bf33d265155a687a5ce62baeb71d3fb02bc32c665cbe022cf46ea737edd2d0"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.46/hasp_1.0.46_linux_arm64.tar.gz"
      sha256 "f01a593c35b37ebd33693939ea3d8b0c9f1b956cc28ea5683a7af176e9462f24"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.46/hasp_1.0.46_linux_amd64.tar.gz"
      sha256 "d0b302a26d9a0770d8c81cfbb0e1093c6183738d5e4e2fd78acc7a370036dc09"
    end
  end
  def install
    libexec.install "bin"
    bin.install_symlink libexec/"bin/hasp"
    (pkgshare/"agent-profiles").install Dir["agent-profiles/*"]
    (pkgshare/"profiles").install Dir["profiles/*"]
    (pkgshare/"scripts").install Dir["scripts/*"]
    pkgshare.install "README.md", "QUICKSTART.md", "OPERATOR_GUIDE.md", "PRODUCTION_GUIDE.md", "RELEASE_MANIFEST", "LICENSE"
  end

  def caveats
    <<~EOS
      Add #{bin} to PATH if it is not already there.
      Set HASP_HOME and HASP_MASTER_PASSWORD before first use.
      Package docs and helper scripts are installed under: #{pkgshare}
      If hasp version does not print #{version}, run: which -a hasp
      Remove or reorder earlier stale binaries such as ~/.local/bin/hasp, then run: hash -r
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
