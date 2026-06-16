class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.37"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.37/hasp_1.0.37_darwin_arm64.tar.gz"
      sha256 "27e3c206f62f26fcb0c6be5da25c2ee82c664ae37144dc071b91294ac379bed9"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.37/hasp_1.0.37_darwin_amd64.tar.gz"
      sha256 "71f0a8a163f16b084f1f44eae8a5d954c3b3638d880f323a740bf0f959a75370"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.37/hasp_1.0.37_linux_arm64.tar.gz"
      sha256 "332f724c674bae8e101c5adc876c2c412e8422c1eaa6f3d79d358e30d2abe6b8"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.37/hasp_1.0.37_linux_amd64.tar.gz"
      sha256 "8913416f8c43e06c3bd76f8b76ff4e653a31165c2f368d309e068dda32e6ab00"
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
