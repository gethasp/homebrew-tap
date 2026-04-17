class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.18"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.18/hasp_0.1.18_darwin_arm64.tar.gz"
      sha256 "14fb3b82869d1991ba4dc95069fe4f09bbe6989e32a5e4ceb0897420dbac8f2b"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.18/hasp_0.1.18_darwin_amd64.tar.gz"
      sha256 "26725693b263e7596d6bb80295e59cd04ac0bd0a090d8f037250f9d76fb657b9"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.18/hasp_0.1.18_linux_arm64.tar.gz"
      sha256 "5ee0c6cac419932f726a8287a1954ecf9b353bed83f49b11e5f24cd08311f2fa"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.18/hasp_0.1.18_linux_amd64.tar.gz"
      sha256 "400366d502bacb7b844bd68dc712301eec7be9682d7c2b7302d45f5c3cb05a67"
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
