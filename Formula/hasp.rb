class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.0"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.0/hasp_0.1.0_darwin_arm64.tar.gz"
      sha256 "8dfdc78d7e58f831dbe4f0f0c5da32f1051020c5041c886c0eacb70320ea3a11"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.0/hasp_0.1.0_darwin_amd64.tar.gz"
      sha256 "f588e1a50379dfd9162dc8514b61072b8666478f0a5f995bff5c0aafaa96d912"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.0/hasp_0.1.0_linux_arm64.tar.gz"
      sha256 "e15744182fa76b84f0029e721831ca2229de2710e4946e2bd996545a27d79393"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.0/hasp_0.1.0_linux_amd64.tar.gz"
      sha256 "5cf0323204cb37ee9708c97776117f35159fc68a30c006febe2c0b31add85e6f"
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
