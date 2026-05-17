class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.21"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.21/hasp_1.0.21_darwin_arm64.tar.gz"
      sha256 "68db3d3e86ac7135dcb286abe086939f0b3d882ff51b3283e916620078363bde"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.21/hasp_1.0.21_darwin_amd64.tar.gz"
      sha256 "ea66a64cd00ad0a98d062b034e246a4d956ef0cbf605fc9e75098067b7fdbf6d"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.21/hasp_1.0.21_linux_arm64.tar.gz"
      sha256 "df35d201174fc3d1022d1463f7991e40309bae7d3fe9c7734fd08509cc799d4c"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.21/hasp_1.0.21_linux_amd64.tar.gz"
      sha256 "2faaed129b05765c8a25409c94dce36bd1b81116098df0c10f6c5d4a13533eeb"
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
