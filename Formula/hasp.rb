class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.6"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.6/hasp_1.0.6_darwin_arm64.tar.gz"
      sha256 "7d3fb875e6780060429af3826720bfbe41bf3be7bd0c58eaaf0f56f5c5fa4e29"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.6/hasp_1.0.6_darwin_amd64.tar.gz"
      sha256 "5903fe478844e22fdc3f55b5cc64c7656b17d1228b7a8e007fed7bdb82da10e9"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.6/hasp_1.0.6_linux_arm64.tar.gz"
      sha256 "6f2e28a50558e078e6ebc1b48d9314e25f0ef89832088bef3b1a978e6457e856"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.6/hasp_1.0.6_linux_amd64.tar.gz"
      sha256 "d7287d0e134bdd3d7f9f991e6a8c94e0439db21f9416142f1364bcb1a26bd769"
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
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
