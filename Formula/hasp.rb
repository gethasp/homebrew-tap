class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.31"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.31/hasp_0.1.31_darwin_arm64.tar.gz"
      sha256 "f3f1a1c8bb62a8ae56f4f92c4ae9659bba20b4a83cb5e3cd862d806e090b0f9b"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.31/hasp_0.1.31_darwin_amd64.tar.gz"
      sha256 "e5db30d1802c10aa209f02b240a0a7859672a67a66b5976b83e01d3ffe1c8e1e"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.31/hasp_0.1.31_linux_arm64.tar.gz"
      sha256 "64e96b3cfd98679324e56730dc968e369b1317e2613a64e38109d336c684d28f"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.31/hasp_0.1.31_linux_amd64.tar.gz"
      sha256 "aaafeb405a8b74ee20970df802d04656f0850913a546dbb5fc440840c5d88721"
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
