class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.27"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.27/hasp_1.0.27_darwin_arm64.tar.gz"
      sha256 "3779385f508cf655e38eb72d89790a5ac4395772a424d6682ef779e804af4602"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.27/hasp_1.0.27_darwin_amd64.tar.gz"
      sha256 "85369847d0e750a420c27ae73fc7767891c7b2c94c7a1104d929ce5d91dcd235"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.27/hasp_1.0.27_linux_arm64.tar.gz"
      sha256 "793932558dd0f55c489022610b96af491a65fa0ef2ebcdf74fee8fd916ccdcd0"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.27/hasp_1.0.27_linux_amd64.tar.gz"
      sha256 "dd461886a9efab01f8295e264b70f8504fc530a3346412c2ffe06fe2d71be467"
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
