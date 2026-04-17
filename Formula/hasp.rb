class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.15"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.15/hasp_0.1.15_darwin_arm64.tar.gz"
      sha256 "e754928dcbf9115455e5a628e0750ed1c37a2c2937a99a5e59308bdce3298101"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.15/hasp_0.1.15_darwin_amd64.tar.gz"
      sha256 "dc2fd7d7283d35435bfeae4dfa10206c59ff8a1d7484913f199490dd5bc3c2dc"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.15/hasp_0.1.15_linux_arm64.tar.gz"
      sha256 "646fc328ba8fd7d81dde1d73340cacf408ca464671a9aeb1392314157f4b1401"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.15/hasp_0.1.15_linux_amd64.tar.gz"
      sha256 "8fbe6beaf0387fab88560588bd974226da79784a497ebabb88047743a94697b5"
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
