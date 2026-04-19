class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.22"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.22/hasp_0.1.22_darwin_arm64.tar.gz"
      sha256 "5f0415cb575a71cde7d5b3ba1fb066b0164e60efcf6660c9b201a333b81b3f6d"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.22/hasp_0.1.22_darwin_amd64.tar.gz"
      sha256 "df5a67c1c5a03a3701510afaa97b884c26ce3967ee9d0a3714bb0e80dfd07e45"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.22/hasp_0.1.22_linux_arm64.tar.gz"
      sha256 "eae612a7d3fb828128066d98340567a62b81a36adba274d9b0c5f5fddd366913"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.22/hasp_0.1.22_linux_amd64.tar.gz"
      sha256 "b19d9607d0ba83f258e54ba5bf556d9d2cc745f82843ecafb8bea8e64ca3f4b9"
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
