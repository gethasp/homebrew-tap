class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.17"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.17/hasp_1.0.17_darwin_arm64.tar.gz"
      sha256 "2edc687b20f7224b80599c312209a679b1c01df6ed243fd9e7b79fe585c05537"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.17/hasp_1.0.17_darwin_amd64.tar.gz"
      sha256 "358784773ac147a727937d7fa9970835f9f4de8e95dbe638d4610da2ce86c3f1"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.17/hasp_1.0.17_linux_arm64.tar.gz"
      sha256 "cfbd8264ce76b18d00eeb862c2961413f6b3b299249e4fe40ebcbb50e1899692"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.17/hasp_1.0.17_linux_amd64.tar.gz"
      sha256 "08064ddcfcee0871cc688a3a1e97d6bb9325f3f9badff8c37e9b8545491d2094"
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
