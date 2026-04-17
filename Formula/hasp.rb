class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.16"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.16/hasp_0.1.16_darwin_arm64.tar.gz"
      sha256 "17091505cae1da7384457e5df433f09d198d60940d189740b92824f70455cfc2"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.16/hasp_0.1.16_darwin_amd64.tar.gz"
      sha256 "104c9e70fedfa82d0da6aefd5d08fe03a4b8c06c7f916b652b9f191ae6eb99dc"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.16/hasp_0.1.16_linux_arm64.tar.gz"
      sha256 "00a96f7f8ef88ba57375c4b1a241cbb37da27238259598d5016877cd2c5e9661"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.16/hasp_0.1.16_linux_amd64.tar.gz"
      sha256 "0d1ac54d0c5189b05a2f1abd045bf2e89b00eaf503d728e35b97da86c1549a02"
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
