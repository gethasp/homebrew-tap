class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.3"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.3/hasp_1.0.3_darwin_arm64.tar.gz"
      sha256 "b7544ffe39c9a946cb5acb6cd1fcbc004d09985a46b6db23a491b38bf8b47569"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.3/hasp_1.0.3_darwin_amd64.tar.gz"
      sha256 "7eed5f4fa1f14cf3c979cf0e75b4a6de60687366a1cb8c14087fa6c73b615b31"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.3/hasp_1.0.3_linux_arm64.tar.gz"
      sha256 "d5f8e30d0c1a17df8f6d147ea5c4af4fd07a0148470aef16ff622e0f881fc850"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.3/hasp_1.0.3_linux_amd64.tar.gz"
      sha256 "e517604571fd7f0757a2df3599cd7186cf0a9e8680aef6d795f9f34a0a38ac60"
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
