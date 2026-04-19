class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.23"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.23/hasp_0.1.23_darwin_arm64.tar.gz"
      sha256 "c33899e7f58ac4bcab649d59b0a56b5b6d1775148fe6a571dfb3b509d95994fe"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.23/hasp_0.1.23_darwin_amd64.tar.gz"
      sha256 "6cdcd13a71ac40106b0a0cc78a78cf2c927dfe62b7f596665561fd8b8d1c146a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.23/hasp_0.1.23_linux_arm64.tar.gz"
      sha256 "294153df9b77fe00fd71eb76c3da8377a4168f9ce0fc44e7422427b88e70023e"
    end
    on_intel do
      url "https://github.com/ehmo/hasp/releases/download/v0.1.23/hasp_0.1.23_linux_amd64.tar.gz"
      sha256 "4738dcf65b75f80e6d4300bf4f75dfe01b5562a6bac1f84f1054c24d88b584d0"
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
