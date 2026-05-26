class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.29"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.29/hasp_1.0.29_darwin_arm64.tar.gz"
      sha256 "f34de1b1c264878e3a11b918e2e2df89afde1293ec6fd004560532cbb1f9e5fb"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.29/hasp_1.0.29_darwin_amd64.tar.gz"
      sha256 "c22795c14f8897a48d39d2c6e91ae1d8ec26613970dc4b556a17e27cf4ccdc47"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.29/hasp_1.0.29_linux_arm64.tar.gz"
      sha256 "b5cd0f9ed95bf6fe069316198ff5cdb39e9a6d1951aecbf9a8ed3383edd6e055"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.29/hasp_1.0.29_linux_amd64.tar.gz"
      sha256 "0154a21c04ebe55f1a6291098e9154a31f88418a322c4230f9e5816968784519"
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
