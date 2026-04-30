class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.36"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.36/hasp_0.1.36_darwin_arm64.tar.gz"
      sha256 "27171dd3371de1fb253a60e9ffa5044a7ebbaaac76897c25348d6e6dc87e667e"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.36/hasp_0.1.36_darwin_amd64.tar.gz"
      sha256 "8e6f9e624b8a01e024128214b9672b275f397ff9859bca0e2f9d50149383d695"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.36/hasp_0.1.36_linux_arm64.tar.gz"
      sha256 "d080cd6945b303e3f053bc7a2e5527f68106b7364eacc52ac05bf05c79b6c1f0"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.36/hasp_0.1.36_linux_amd64.tar.gz"
      sha256 "ecd0dbfbdeb03262969168653bf0639583ae1f1e217f2a077aa1f90c5c2f1cbb"
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
