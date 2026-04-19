class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.26"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.26/hasp_0.1.26_darwin_arm64.tar.gz"
      sha256 "1899a863e8dc6fcb686663626f68e664d77cd5c890bee09417cd010a60b1d933"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.26/hasp_0.1.26_darwin_amd64.tar.gz"
      sha256 "f6b7d6d451f6d329f1718781ee05db6177b8dd2f185fd6d4d6487f69b5aed835"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.26/hasp_0.1.26_linux_arm64.tar.gz"
      sha256 "fb2e45c04f0d172bf5d74a8f4c6878a42a17051759cc8b6b9394a9600114097d"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.26/hasp_0.1.26_linux_amd64.tar.gz"
      sha256 "92324683e7156a5c41db7c00f66f3958f89fcaca3e81272431ad7b683f17216e"
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
