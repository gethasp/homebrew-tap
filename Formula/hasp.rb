class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.17"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.17/hasp_0.1.17_darwin_arm64.tar.gz"
      sha256 "f2f03c7bbb945d74512a8dc61a9db38798206c2d2e511ca30912279e9c2c9566"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.17/hasp_0.1.17_darwin_amd64.tar.gz"
      sha256 "d1a829d60f00465ddf53022bb2f9f71b84b50a5c12033f0fd5a432656c6f31f3"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.17/hasp_0.1.17_linux_arm64.tar.gz"
      sha256 "29a493a1e6cbd36624ed9f4c033c6ed346ce51a65af91cd16af297448fcb9c27"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.17/hasp_0.1.17_linux_amd64.tar.gz"
      sha256 "d96521a56172fd6c58af6e5a19d613f0542025495aa7baf0b4b46e33adddfd5d"
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
