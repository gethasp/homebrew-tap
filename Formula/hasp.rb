class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.24"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.24/hasp_0.1.24_darwin_arm64.tar.gz"
      sha256 "efe85e9863258321f8339526475c0e1bcc1248750ca125220ab11c612e41711c"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.24/hasp_0.1.24_darwin_amd64.tar.gz"
      sha256 "5d44db70ae15c2ef2481b097834a6771626cfceb2b3fa09e3bc4f52c0060ffb4"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.24/hasp_0.1.24_linux_arm64.tar.gz"
      sha256 "7a24ea1abea97308e3565bcc3ceb01c05689087f249233e5c4c1ba6323c475c7"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.24/hasp_0.1.24_linux_amd64.tar.gz"
      sha256 "829448b1bb0a5e02d9ff39a4697c753860ea002010e5e72e33bbf7d3e678b0d9"
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
