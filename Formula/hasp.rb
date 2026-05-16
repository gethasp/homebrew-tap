class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.18"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.18/hasp_1.0.18_darwin_arm64.tar.gz"
      sha256 "318c27d78e7135cf541f18821d1a8ff7a59031e8101bf99ca94dcb6b7af2c28c"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.18/hasp_1.0.18_darwin_amd64.tar.gz"
      sha256 "7d1c84de6eeb5ec48d13a5c06e8e5c4948f6231e2398e57832221ec3621ec96f"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.18/hasp_1.0.18_linux_arm64.tar.gz"
      sha256 "bb3b99bd37f077b2b44229087a4a9084cdcafd0266bdaf6e2dbde2b75d39e35c"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.18/hasp_1.0.18_linux_amd64.tar.gz"
      sha256 "630732fe4b8b838af351b29d539ae9e2a6362acd771ce494a1a793ce79c7dbc2"
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
