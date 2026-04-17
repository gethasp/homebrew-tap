class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.12"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.12/hasp_0.1.12_darwin_arm64.tar.gz"
      sha256 "8878cf4ab26aab5e74dc411d9955958fbbf5332042900d98ea1ba37632e60fed"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.12/hasp_0.1.12_darwin_amd64.tar.gz"
      sha256 "7f3fe463a3c78d0621e1e70f7bc7db21f06954833395929389439b5210ec1281"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.12/hasp_0.1.12_linux_arm64.tar.gz"
      sha256 "654b2fca122521669e9aad18f14e7dbf63e7d495e49cd6d7f8dc61b06ac52ff5"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.12/hasp_0.1.12_linux_amd64.tar.gz"
      sha256 "187204aaad4bced168450de5759dde00c13bebc9dc8b79bb5e9a55c429103e5e"
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
