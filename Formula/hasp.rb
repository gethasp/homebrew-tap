class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.32"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.32/hasp_0.1.32_darwin_arm64.tar.gz"
      sha256 "9feb77f84dce1fe33d9aa6901160ab8e5b654c1ffec18aa5ac343704097e59be"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.32/hasp_0.1.32_darwin_amd64.tar.gz"
      sha256 "731de44c1e8329ea6ab89af8b5f7644b606df8a26184d159f522681ad228cc1c"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.32/hasp_0.1.32_linux_arm64.tar.gz"
      sha256 "24ff7ea6b65141755a837e37c43dae5500300464da23f625c7fb801f31c79e25"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.32/hasp_0.1.32_linux_amd64.tar.gz"
      sha256 "f237ccc5f0446ca00bbd47c1aea388254d59c67492e3552f310c63b1fc8bbb5d"
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
