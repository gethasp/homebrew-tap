class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.30"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.30/hasp_1.0.30_darwin_arm64.tar.gz"
      sha256 "fd3c60878c8280039203840bf3e4e825dbdd97d60001a67e3be81ebaf983b19c"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.30/hasp_1.0.30_darwin_amd64.tar.gz"
      sha256 "f0a85502c657bea697e21baaae840dab5792d8501577bcaa5f634d70f739a40e"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.30/hasp_1.0.30_linux_arm64.tar.gz"
      sha256 "3a4ff9095631364110de96e57ec53e936a2c219f47a1f8af4aa15b75ee6facaf"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.30/hasp_1.0.30_linux_amd64.tar.gz"
      sha256 "3f236a554d30344cd6447a7bc8ad2d536825b1f8609d352b04f1c9bda82781e0"
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
