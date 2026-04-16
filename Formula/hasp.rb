class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.3"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.3/hasp_0.1.3_darwin_arm64.tar.gz"
      sha256 "e2b140f82864bb8c6746736e6ba9216b6a7a77bf4ae0571855bc53341b11272d"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.3/hasp_0.1.3_darwin_amd64.tar.gz"
      sha256 "3761499ea5ace3e87cfca4f7493faa57a9d0ed42355b0c6ada82e9dbd55fa69d"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.3/hasp_0.1.3_linux_arm64.tar.gz"
      sha256 "470dfce7b77381f878498691ee7d71b2bebd0a8183ca65aee272bb89ab0ffdfc"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.3/hasp_0.1.3_linux_amd64.tar.gz"
      sha256 "285547e871fa2a6d5deafe9bedf4e238677c5fd4128d266e96a72ce6dc0ec21c"
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
