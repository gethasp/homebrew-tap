class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.11"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.11/hasp_1.0.11_darwin_arm64.tar.gz"
      sha256 "d401d2616fd29d524bdd0d60389d302162586218ce7dc4f09c947d6137acc036"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.11/hasp_1.0.11_darwin_amd64.tar.gz"
      sha256 "c536885f4b54942af3f87ebe64676fccb548d22cfe1aee4a31c4eceacd40a850"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.11/hasp_1.0.11_linux_arm64.tar.gz"
      sha256 "73c517c91f7c1911227020e0b1aeee36d5bdc180296b61aeb78e723dbc1a3076"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.11/hasp_1.0.11_linux_amd64.tar.gz"
      sha256 "cef1e27938db6b24e598c99392bf683f557390434a2a5153c4c9ca83434bb9c7"
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
