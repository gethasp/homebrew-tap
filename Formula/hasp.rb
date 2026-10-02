class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.44"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.44/hasp_1.0.44_darwin_arm64.tar.gz"
      sha256 "80ed01b0c842521f9cc1176fdc4a8581d92281d515bc656ac1ca48f3c1eb2c3e"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.44/hasp_1.0.44_darwin_amd64.tar.gz"
      sha256 "80255aa588ada0c6467736286c716ea49480bc123ecacf3a8879f5f1e5f1058c"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.44/hasp_1.0.44_linux_arm64.tar.gz"
      sha256 "3297643577e7b96645d1b56874b2e0da0138a630a126c7e1e8beefdb778ae80c"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.44/hasp_1.0.44_linux_amd64.tar.gz"
      sha256 "c288788e8a579984d171219f1722def430b0a72aabccf5db34e94dddcecc99c6"
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
