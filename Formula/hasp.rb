class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.15"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.15/hasp_1.0.15_darwin_arm64.tar.gz"
      sha256 "9a7a15d40da032aadf0f62ed472f6e9d4a6f1e731ececb913f880631eba61f05"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.15/hasp_1.0.15_darwin_amd64.tar.gz"
      sha256 "1fe06c56115e71eb70347da9056a32a1ae0829a6464c799263e2a317dcba4ae6"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.15/hasp_1.0.15_linux_arm64.tar.gz"
      sha256 "c582431da64f9e6dced54af8fc192c4513e72acff89012983107d63e6465a426"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.15/hasp_1.0.15_linux_amd64.tar.gz"
      sha256 "4a3f8e6937e00ac5d48898d841b3c0b08572843e7262f9623864cc4863030e34"
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
