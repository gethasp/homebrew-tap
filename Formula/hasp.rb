class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.38"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.38/hasp_0.1.38_darwin_arm64.tar.gz"
      sha256 "9ca0adf6a0fd3f614f4722075eba87ab14bbb13c3b1b34e8fbf58c443f333c9d"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.38/hasp_0.1.38_darwin_amd64.tar.gz"
      sha256 "522e2b632d8f6c4a86651741a62bf77fba41d4531c26865775656508ce1de139"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.38/hasp_0.1.38_linux_arm64.tar.gz"
      sha256 "62c8310d2f34f1e74f69bfdaa14b8cbc2987f17dd5318f46af2c4c20afbb9c2b"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.38/hasp_0.1.38_linux_amd64.tar.gz"
      sha256 "82dd42add5472f877100c6f7c42eaa483b9f3b2fee7b069e0020b1fcdbea3816"
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
