class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.32"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.32/hasp_1.0.32_darwin_arm64.tar.gz"
      sha256 "8e0baa8e1c64fcd1715d114948f91e457558ad20637baf7a36ec45129ba73830"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.32/hasp_1.0.32_darwin_amd64.tar.gz"
      sha256 "8c1d1c97d1a201ef3b344831d3adf1fbb6eb23564162cc4ebf45cd7f054b73dc"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.32/hasp_1.0.32_linux_arm64.tar.gz"
      sha256 "484c0bb70ae5f7bce346525bc1adde5f5467752f1b80f6ef0ebe5312c1810cef"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.32/hasp_1.0.32_linux_amd64.tar.gz"
      sha256 "8b398656de7e047478a27db3f6316ec794bf0555020ec2711d2ddc7f31c71b2e"
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
      If hasp version does not print #{version}, run: which -a hasp
      Remove or reorder earlier stale binaries such as ~/.local/bin/hasp, then run: hash -r
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
