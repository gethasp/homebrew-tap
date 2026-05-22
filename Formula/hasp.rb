class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.25"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.25/hasp_1.0.25_darwin_arm64.tar.gz"
      sha256 "d03f216327aa2f6446154d1b0266069f6632e298f405dabde20b302e326e25d9"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.25/hasp_1.0.25_darwin_amd64.tar.gz"
      sha256 "3c330894b3835a3fe0eae97c5819e89297bd8ca11cc8fca44f25da29579a835e"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.25/hasp_1.0.25_linux_arm64.tar.gz"
      sha256 "c29f20229ef58c880d2d6dad0dd9086614b9dd93d08948331f7f0a702c55bea9"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.25/hasp_1.0.25_linux_amd64.tar.gz"
      sha256 "b26ef159d122fb254d8090357d2f12172d93f21499af091905b0089f1daeaa88"
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
