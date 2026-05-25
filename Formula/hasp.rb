class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.26"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.26/hasp_1.0.26_darwin_arm64.tar.gz"
      sha256 "8163ff768980ffdb1cd55c242978585b5032356f9d42cd2fd1aca85c8d7b4df4"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.26/hasp_1.0.26_darwin_amd64.tar.gz"
      sha256 "a418c31b9c1f8060b78a719ca629a974564eeb69515db503ac24ac99db7c9a64"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.26/hasp_1.0.26_linux_arm64.tar.gz"
      sha256 "42cd24e5d0f3652bf9e7aed8bcde457aa1b6e68efc802eb498964a21e8996b14"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.26/hasp_1.0.26_linux_amd64.tar.gz"
      sha256 "bef0afab16c508c503c5dc964adaa98791c0e0381f9a750dc53d9f4f7bcc8fda"
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
