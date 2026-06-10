class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.36"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.36/hasp_1.0.36_darwin_arm64.tar.gz"
      sha256 "c890e718c396370cec7953831dd9a68b41add876df15031a7b330d4eb9aa7b88"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.36/hasp_1.0.36_darwin_amd64.tar.gz"
      sha256 "c57752d0eed8f99fa6e4e7e1d881d722163c4c34d6cd0db6b658c9750056314e"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.36/hasp_1.0.36_linux_arm64.tar.gz"
      sha256 "12656d434699921904cee08b6ebf1173135510f2bae3f2657551c46d59d5c805"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.36/hasp_1.0.36_linux_amd64.tar.gz"
      sha256 "ceba2e27b8808ef33574843723f80f2f7120436e39dd39f86aaab38ab39d2dae"
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
