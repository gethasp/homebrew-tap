class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.20"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.20/hasp_0.1.20_darwin_arm64.tar.gz"
      sha256 "4fe99e9efd50074923ad59122cc666a0aa104cf16bf45f4163caa16cb9baafbe"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.20/hasp_0.1.20_darwin_amd64.tar.gz"
      sha256 "3523ce213e020f4f58c89bec489e95413e8a41e4cd1692fa3c0e9d67165c64d7"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.20/hasp_0.1.20_linux_arm64.tar.gz"
      sha256 "5f55e40ec69364c57a5bba48f0e9a63201f39d5efdf828bb63f7b7ddc30a91ee"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.20/hasp_0.1.20_linux_amd64.tar.gz"
      sha256 "e554bf3a859eae217cb4964ab43c90f0f8b2053a0498abcfa9a44d81812162c5"
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
