class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.39"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.39/hasp_1.0.39_darwin_arm64.tar.gz"
      sha256 "20e86d69f4dec4b25c5343510ab5b66eb00f8bbde0aa31a98e3c878feb470783"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.39/hasp_1.0.39_darwin_amd64.tar.gz"
      sha256 "4eb6456597555756a728c517efa7957bd59e94abeb8a9bbd2b70e61f926023b0"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.39/hasp_1.0.39_linux_arm64.tar.gz"
      sha256 "e845ffa22e5e33004ac60cd31db90f7cee85b58816e6e567c5449a38c22cd0c9"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.39/hasp_1.0.39_linux_amd64.tar.gz"
      sha256 "c352b79ef417ff2c0c083888b62c9048e9d34ba4d3647bdc8aa2bd8b2662de78"
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
