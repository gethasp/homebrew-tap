class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.19"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.19/hasp_1.0.19_darwin_arm64.tar.gz"
      sha256 "397a6b572b8b6d5f57229bb9397ff023256081a860adcb696b4b9e3c43e759c1"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.19/hasp_1.0.19_darwin_amd64.tar.gz"
      sha256 "2b6cc7412f15d12f40445129e0b0b4e4c29065b20af62fc240608a4ab648ea15"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.19/hasp_1.0.19_linux_arm64.tar.gz"
      sha256 "c5221fc8b40ada5112dd7f93075d3582f71c43c2635024790cadccf589a246d8"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.19/hasp_1.0.19_linux_amd64.tar.gz"
      sha256 "5cc5cb6c2c8a3437afb8c9746ab6653ff4027ce6bee375f1907ed58323521d87"
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
