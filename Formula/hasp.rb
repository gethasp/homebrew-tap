class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.24"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.24/hasp_1.0.24_darwin_arm64.tar.gz"
      sha256 "a5471fcc624e6fb117dc5473e1bd2cc5f99641e35d2a37efa5e8f467058eb5b2"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.24/hasp_1.0.24_darwin_amd64.tar.gz"
      sha256 "e2a22082aa186e6a0492b2605e9c4f2962f507614574ce51f11432a4100c6097"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.24/hasp_1.0.24_linux_arm64.tar.gz"
      sha256 "aec57cc1c96e1cacf9ffe992fe5d7b2edb26439d431eb07800db019b134a56c3"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.24/hasp_1.0.24_linux_amd64.tar.gz"
      sha256 "2837d66bef257edb6d0fbd58a3cac0ba9b790734f27732f99a76585c3c3d63d6"
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
