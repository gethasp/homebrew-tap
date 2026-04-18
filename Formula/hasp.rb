class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.21"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.21/hasp_0.1.21_darwin_arm64.tar.gz"
      sha256 "883559488251028a6c1cfa95f332fbbc3cf6ae11613dbe7c9e35f6d8fb67c0cb"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.21/hasp_0.1.21_darwin_amd64.tar.gz"
      sha256 "e73c155824a29ca41bd09209af34208a5f2779fa7739f420d815add3720041d8"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.21/hasp_0.1.21_linux_arm64.tar.gz"
      sha256 "003d63bf69e49225182a277951bd15f91c6e96f6a288389321ed79fc68b4f8a6"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.21/hasp_0.1.21_linux_amd64.tar.gz"
      sha256 "af0f3aee915f711cc80ebf6fc7bfeaa45b66e3db56e766347a64dd391fb3c0d2"
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
