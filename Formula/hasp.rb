class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.11"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.11/hasp_0.1.11_darwin_arm64.tar.gz"
      sha256 "fd935c2fd17c83ae96675ed5f74ef241ec00b1240c955bb3ab3359c18afa865d"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.11/hasp_0.1.11_darwin_amd64.tar.gz"
      sha256 "2e0fb25e2a7b5d4907dd989cd56b36cac63623fad7d2b060ba01d40efe172242"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.11/hasp_0.1.11_linux_arm64.tar.gz"
      sha256 "c348127c2ccc83ea2f18a60aaa4b70fb13a5046fff717ac282549f89a18f373b"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.11/hasp_0.1.11_linux_amd64.tar.gz"
      sha256 "91c18f78d575c710c071a67fa9b846b9eecc120abe9d4a45eb44f1f9adabd8c7"
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
